############################################################################
##
## Copyright (C) 2019 The Qt Company Ltd.
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

SRC_URI_append_mx8 = " file://kms.conf"

do_configure_append() {
    echo "FB_MULTI_BUFFER=2" >> ${WORKDIR}/defaults
    echo "QT_QPA_EGLFS_FORCEVSYNC=1" >> ${WORKDIR}/defaults
}

do_configure_append_mx6() {
    echo "QT_GSTREAMER_CAMERABIN_VIDEOSRC=mxc_v4l2=imxv4l2videosrc,v4l2src" >> ${WORKDIR}/defaults
}

IMXCONVERTER ?= ""
IMXCONVERTER_mx8 = "imxvideoconvert_g2d"
IMXCONVERTER_mx8mm = ""

do_configure_append_mx8() {
    echo "QT_QPA_EGLFS_FORCE888=1" >> ${WORKDIR}/defaults
    echo "QT_QPA_EGLFS_KMS_ATOMIC=1" >> ${WORKDIR}/defaults
    echo "QT_QPA_EGLFS_KMS_CONFIG=/etc/kms.conf" >> ${WORKDIR}/defaults
    if [ -n "${IMXCONVERTER}" ]; then
        echo "QT_GSTREAMER_PLAYBIN_CONVERT=${IMXCONVERTER}" >> ${WORKDIR}/defaults
    fi
}

do_install_append_mx8() {
    install -m 0644 ${WORKDIR}/kms.conf ${D}${sysconfdir}/
}

do_configure_append_mx8mm() {
    # QtWebEngine screen tearing issues with imx8mm (QTBUG-80665)
    echo "QTWEBENGINE_DISABLE_GPU_THREAD=1" >> ${WORKDIR}/defaults
}
