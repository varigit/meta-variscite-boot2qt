############################################################################
##
## Copyright (C) 2018 The Qt Company Ltd.
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

build_hddimg_append() {
    rm -f ${IMGDEPLOYDIR}/${IMAGE_LINK_NAME}.img
    ln -s ${IMAGE_NAME}.hddimg ${IMGDEPLOYDIR}/${IMAGE_LINK_NAME}.img
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
    ./tegra*-flash/mksparse -v --fillpattern=0 ${IMAGE_LINK_NAME}.${IMAGE_TEGRAFLASH_FS_TYPE} ${IMAGE_BASENAME}.img
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

do_image_teziimg[depends] += "qtbase-native:do_populate_sysroot"
IMAGE_CMD_teziimg_append() {
    ${IMAGE_CMD_TAR} --transform 's,^,${IMAGE_NAME}-Tezi_${PV}/,' -rhf ${IMGDEPLOYDIR}/${IMAGE_NAME}-Tezi_${PV}${TDX_VERDATE}.tar TEZI_B2QT_EULA.TXT Built_with_Qt.png
    ln -fs ${IMAGE_NAME}-Tezi_${PV}${TDX_VERDATE}.tar ${IMGDEPLOYDIR}/${IMAGE_LINK_NAME}.tezi.tar
}
python rootfs_tezi_json_append() {
    import subprocess
    qtversion = subprocess.check_output(['qmake', '-query', 'QT_VERSION']).decode('utf-8').strip()

    data["license_title"] = "QT DEMO IMAGE END USER LICENSE AGREEMENT"
    data["license"] = "TEZI_B2QT_EULA.TXT"
    data["version"] = "Qt " + qtversion
    data["icon"] = "Built_with_Qt.png"

    with open(os.path.join(deploy_dir, 'image.json'), 'w') as outfile:
        json.dump(data, outfile, indent=4)
}
