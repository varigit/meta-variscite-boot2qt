############################################################################
##
## Copyright (C) 2016 The Qt Company Ltd.
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
SDCARD_ROOTFS = "${IMGDEPLOYDIR}/${IMAGE_NAME}.rootfs.ext3"
SDCARD_GENERATION_COMMAND ?= "generate_imx_sdcard"

IMAGE_CMD_sdcard_append() {
    parted -s ${SDCARD} set 1 boot on

    rm -f ${IMGDEPLOYDIR}/${IMAGE_LINK_NAME}.img
    ln -s ${IMAGE_NAME}.rootfs.sdcard ${IMGDEPLOYDIR}/${IMAGE_LINK_NAME}.img
}

IMAGE_CMD_rpi-sdimg_append() {
    rm -f ${IMGDEPLOYDIR}/${IMAGE_LINK_NAME}.img
    ln -s ${IMAGE_NAME}.rootfs.rpi-sdimg ${IMGDEPLOYDIR}/${IMAGE_LINK_NAME}.img
}

build_hddimg_append() {
    rm -f ${IMGDEPLOYDIR}/${IMAGE_LINK_NAME}.img
    ln -s ${IMAGE_NAME}.hddimg ${IMGDEPLOYDIR}/${IMAGE_LINK_NAME}.img
}

IMAGE_DEPENDS_tegraflash_append = " parted-native:do_populate_sysroot"
create_tegraflash_pkg_prepend() {
    # Create partition table
    SDCARD=${IMGDEPLOYDIR}/${IMAGE_NAME}.img
    SDCARD_ROOTFS=${IMGDEPLOYDIR}/${IMAGE_LINK_NAME}.ext4
    SDCARD_SIZE=$(expr ${IMAGE_ROOTFS_ALIGNMENT} + ${ROOTFS_SIZE} + ${IMAGE_ROOTFS_ALIGNMENT})

    dd if=/dev/zero of=$SDCARD bs=1 count=0 seek=$(expr 1024 \* $SDCARD_SIZE)

    parted -s $SDCARD mklabel gpt
    parted -s $SDCARD unit KiB mkpart primary ${IMAGE_ROOTFS_ALIGNMENT} $(expr ${IMAGE_ROOTFS_ALIGNMENT} \+ ${ROOTFS_SIZE})
    parted $SDCARD print

    dd if=$SDCARD_ROOTFS of=$SDCARD conv=notrunc,fsync seek=1 bs=$(expr ${IMAGE_ROOTFS_ALIGNMENT} \* 1024)

    rm -f ${IMGDEPLOYDIR}/${IMAGE_LINK_NAME}.img
    ln -s ${IMAGE_NAME}.img ${IMGDEPLOYDIR}/${IMAGE_LINK_NAME}.img
}
