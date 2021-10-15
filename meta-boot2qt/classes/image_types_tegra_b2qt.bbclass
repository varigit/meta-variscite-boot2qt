############################################################################
##
## Copyright (C) 2021 The Qt Company Ltd.
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

# create flash package that utilizes the SD card image
create_tegraflash_pkg:append() {
    cd ${WORKDIR}/tegraflash
    cat > prepare-image.sh <<END
#!/bin/sh -e
if [ ! -e "${IMAGE_BASENAME}.img" ]; then
    xz -dc ../${IMAGE_LINK_NAME}.wic.xz | dd of=${IMAGE_LINK_NAME}.${IMAGE_TEGRAFLASH_FS_TYPE} iflag=fullblock skip=1 bs=$(expr ${IMAGE_ROOTFS_ALIGNMENT} \* 1024) count=$(expr ${ROOTFS_SIZE} / 1024)
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
