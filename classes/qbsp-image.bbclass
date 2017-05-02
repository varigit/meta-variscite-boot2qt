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

QBSP_IMAGE_CONTENT ??= ""

do_image_complete[depends] += "p7zip-native:do_populate_sysroot"

fakeroot do_qbsp_image () {
    if [ -z "${QBSP_IMAGE_CONTENT}" ]; then
        exit 0
    fi

    mkdir -p ${S}/qbsp

    for item in ${QBSP_IMAGE_CONTENT}; do
        src=`echo $item | awk -F':' '{ print $1 }'`
        dst=`echo $item | awk -F':' '{ print $2 }'`

        install -D -m 0755 ${IMGDEPLOYDIR}/$src ${S}/qbsp/$dst
    done

    cd ${S}/qbsp
    7zr a ${IMGDEPLOYDIR}/${IMAGE_NAME}.7z .

    rm -f ${IMGDEPLOYDIR}/${IMAGE_LINK_NAME}.7z
    ln -s ${IMAGE_NAME}.7z ${IMGDEPLOYDIR}/${IMAGE_LINK_NAME}.7z
}

IMAGE_POSTPROCESS_COMMAND += "do_qbsp_image;"
