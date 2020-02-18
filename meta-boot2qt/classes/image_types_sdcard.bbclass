############################################################################
##
## Copyright (C) 2020 The Qt Company Ltd.
## Contact: https://www.qt.io/licensing/
##
## This file is part of the Boot to Qt meta layer.
##
## $QT_BEGIN_LICENSE:GPL$
## Commercial License Usage
## Licensees holding valid commercial Qt licenses may use this file in
## accordance with the commercial license agreement provided with the
## Software or, alternatively, in accordance with the terms contained in
## a written agreement between you and The Qt Company. For licensing terms
## and conditions see https://www.qt.io/terms-conditions. For further
## information use the contact form at https://www.qt.io/contact-us.
##
## GNU General Public License Usage
## Alternatively, this file may be used under the terms of the GNU
## General Public License version 3 or (at your option) any later version
## approved by the KDE Free Qt Foundation. The licenses are as published by
## the Free Software Foundation and appearing in the file LICENSE.GPL3
## included in the packaging of this file. Please review the following
## information to ensure the GNU General Public License requirements will
## be met: https://www.gnu.org/licenses/gpl-3.0.html.
##
## $QT_END_LICENSE$
##
############################################################################

IMAGE_ROOTFS_EXTRA_SPACE = "100000"

IMAGE_CMD_wic_append() {
    rm -f ${IMGDEPLOYDIR}/${IMAGE_LINK_NAME}.img
    ln -s ${IMAGE_NAME}.rootfs.wic ${IMGDEPLOYDIR}/${IMAGE_LINK_NAME}.img
}

IMAGE_CMD_rpi-sdimg_append() {
    rm -f ${IMGDEPLOYDIR}/${IMAGE_LINK_NAME}.img
    ln -s ${IMAGE_NAME}.rootfs.rpi-sdimg ${IMGDEPLOYDIR}/${IMAGE_LINK_NAME}.img
}

do_image_tegraflash[depends] += "parted-native:do_populate_sysroot"
create_tegraflash_pkg_prepend() {
    # Create partition table
    SDCARD=${IMGDEPLOYDIR}/${IMAGE_NAME}.img
    SDCARD_ROOTFS=${IMGDEPLOYDIR}/${IMAGE_LINK_NAME}.${IMAGE_TEGRAFLASH_FS_TYPE}
    SDCARD_SIZE=$(expr ${IMAGE_ROOTFS_ALIGNMENT} + ${ROOTFS_SIZE} + ${IMAGE_ROOTFS_ALIGNMENT})

    dd if=/dev/zero of=$SDCARD bs=1 count=0 seek=$(expr 1024 \* $SDCARD_SIZE)

    parted -s $SDCARD mklabel gpt
    parted -s $SDCARD unit KiB mkpart primary ${IMAGE_ROOTFS_ALIGNMENT} $(expr ${IMAGE_ROOTFS_ALIGNMENT} \+ ${ROOTFS_SIZE})
    parted $SDCARD print

    dd if=$SDCARD_ROOTFS of=$SDCARD conv=notrunc,fsync seek=1 bs=$(expr ${IMAGE_ROOTFS_ALIGNMENT} \* 1024)

    rm -f ${IMGDEPLOYDIR}/${IMAGE_LINK_NAME}.img
    ln -s ${IMAGE_NAME}.img ${IMGDEPLOYDIR}/${IMAGE_LINK_NAME}.img
}

# create flash package that utilizes the SD card image
create_tegraflash_pkg_append() {
    cd ${WORKDIR}/tegraflash
    cat > prepare-image.sh <<END
#!/bin/sh -e
if [ ! -e "${IMAGE_BASENAME}.img" ]; then
    dd if=../${IMAGE_LINK_NAME}.img of=${IMAGE_LINK_NAME}.${IMAGE_TEGRAFLASH_FS_TYPE} skip=1 bs=$(expr ${IMAGE_ROOTFS_ALIGNMENT} \* 1024) count=$(expr ${ROOTFS_SIZE} / 1024)
    ./mksparse -v --fillpattern=0 ${IMAGE_LINK_NAME}.${IMAGE_TEGRAFLASH_FS_TYPE} ${IMAGE_BASENAME}.img
    rm -f ${IMAGE_LINK_NAME}.${IMAGE_TEGRAFLASH_FS_TYPE}
fi
echo "Flash image ready"
END
    chmod +x prepare-image.sh
    rm ${IMAGE_BASENAME}.img

    cd ..
    rm -f ${IMGDEPLOYDIR}/${IMAGE_NAME}.flasher.tar.gz
    tar czhf ${IMGDEPLOYDIR}/${IMAGE_NAME}.flasher.tar.gz tegraflash
    ln -sf ${IMAGE_NAME}.flasher.tar.gz ${IMGDEPLOYDIR}/${IMAGE_LINK_NAME}.flasher.tar.gz
}

do_image[depends] += "qtbase-native:do_populate_sysroot"
IMAGE_CMD_teziimg_append() {
    ${IMAGE_CMD_TAR} --transform 's,^,${IMAGE_NAME}-Tezi_${TEZI_VERSION}/,' -rhf ${IMGDEPLOYDIR}/${IMAGE_NAME}-Tezi_${TEZI_VERSION}.tar TEZI_B2QT_EULA.TXT Built_with_Qt.png
    ln -fs ${TEZI_IMAGE_NAME}-Tezi_${TEZI_VERSION}.tar ${IMGDEPLOYDIR}/${IMAGE_LINK_NAME}.tezi.tar
}

def rootfs_tezi_json_b2qt(d, flash_type, flash_data, json_file, uenv_file):
    import json
    from collections import OrderedDict
    from datetime import datetime
    import subprocess
    qtversion = subprocess.check_output(['qmake', '-query', 'QT_VERSION']).decode('utf-8').strip()

    deploydir = d.getVar('DEPLOY_DIR_IMAGE')
    data = OrderedDict({ "config_format": 2, "autoinstall": False })

    # Use image recipes SUMMARY/DESCRIPTION...
    data["name"] = d.getVar('SUMMARY')
    data["description"] = d.getVar('DESCRIPTION')
    data["version"] = "Qt " + qtversion
    data["release_date"] = datetime.strptime(d.getVar('DATE', False), '%Y%m%d').date().isoformat()
    data["u_boot_env"] = uenv_file
    if os.path.exists(os.path.join(deploydir, "prepare.sh")):
        data["prepare_script"] = "prepare.sh"
    if os.path.exists(os.path.join(deploydir, "wrapup.sh")):
        data["wrapup_script"] = "wrapup.sh"
    if os.path.exists(os.path.join(deploydir, "marketing.tar")):
        data["marketing"] = "marketing.tar"
    data["license_title"] = "QT DEMO IMAGE END USER LICENSE AGREEMENT"
    data["license"] = "TEZI_B2QT_EULA.TXT"
    data["icon"] = "Built_with_Qt.png"

    product_ids = d.getVar('TORADEX_PRODUCT_IDS')
    if product_ids is None:
        bb.fatal("Supported Toradex product ids missing, assign TORADEX_PRODUCT_IDS with a list of product ids.")

    dtmapping = d.getVarFlags('TORADEX_PRODUCT_IDS')
    data["supported_product_ids"] = []

    # If no varflags are set, we assume all product ids supported with single image/U-Boot
    if dtmapping is not None:
        for f, v in dtmapping.items():
            dtbflashtypearr = v.split(',')
            if len(dtbflashtypearr) < 2 or dtbflashtypearr[1] == flash_type:
                data["supported_product_ids"].append(f)
    else:
        data["supported_product_ids"].extend(product_ids.split())

    if flash_type == "rawnand":
        data["mtddevs"] = flash_data
    elif flash_type == "emmc":
        data["blockdevs"] = flash_data

    with open(os.path.join(d.getVar('IMGDEPLOYDIR'), json_file), 'w') as outfile:
        json.dump(data, outfile, indent=4)
    bb.note("Toradex Easy Installer metadata file {0} written.".format(json_file))

python rootfs_tezi_run_json_append() {
    # rewrite image.json with our data
    rootfs_tezi_json_b2qt(d, flash_type, flash_data, "image-%s.json" % d.getVar('IMAGE_BASENAME'), uenv_file)
}
