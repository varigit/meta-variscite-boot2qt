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

inherit image_types

do_image_conf[depends] += "qtbase-native:do_populate_sysroot xz-native:do_populate_sysroot file-native:do_populate_sysroot gawk-native:do_populate_sysroot"

DEPLOY_CONF_NAME ?= "${MACHINE}"
DEPLOY_CONF_TYPE ?= "Boot2Qt"
DEPLOY_CONF_IMAGE_TYPE ?= ""
DEPLOY_CONF_IMAGE_DEP ?= "${DEPLOY_CONF_IMAGE_TYPE}"

IMAGE_CMD_conf() {
    IMAGE_UNCOMPRESSED_SIZE=0
    IMAGE_TYPE=$(file -L ${IMGDEPLOYDIR}/${IMAGE_LINK_NAME}.${DEPLOY_CONF_IMAGE_TYPE} | awk '{ print $2 }')
    if [ -e "${IMGDEPLOYDIR}/${IMAGE_LINK_NAME}.${DEPLOY_CONF_IMAGE_TYPE}" ] && [ "${IMAGE_TYPE}" = "XZ" ] ; then
        IMAGE_UNCOMPRESSED_SIZE=$(xz --robot --list ${IMGDEPLOYDIR}/${IMAGE_LINK_NAME}.${DEPLOY_CONF_IMAGE_TYPE} | awk -F ' ' '{if (NR==2){ print $5 }}')
    fi

    QT_VERSION=$(qmake -query QT_VERSION)
    cat > ${IMGDEPLOYDIR}/${IMAGE_NAME}.rootfs.conf <<EOF
[${DEPLOY_CONF_NAME}]
platform=${MACHINE}
product=${DEPLOY_CONF_TYPE}
qt=Qt $QT_VERSION
os=linux
imagefile=${IMAGE_LINK_NAME}.${DEPLOY_CONF_IMAGE_TYPE}
imageuncompressedsize=$IMAGE_UNCOMPRESSED_SIZE
asroot=true
EOF
}
IMAGE_TYPEDEP_conf = "${DEPLOY_CONF_IMAGE_DEP}"
