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

FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://kms.conf.in"

# Default DRI device to use with KMS
DRI_DEVICE ?= "card0"

do_configure:append() {
    echo "FB_MULTI_BUFFER=2" >> ${WORKDIR}/defaults
    echo "QT_QPA_EGLFS_FORCEVSYNC=1" >> ${WORKDIR}/defaults
}

do_configure:append:mx8() {
    echo "QT_QPA_EGLFS_FORCE888=1" >> ${WORKDIR}/defaults
    echo "QT_QPA_EGLFS_KMS_ATOMIC=1" >> ${WORKDIR}/defaults
    echo "QT_QPA_EGLFS_KMS_CONFIG=/etc/kms.conf" >> ${WORKDIR}/defaults
    sed -e 's/@DEVICE@/${DRI_DEVICE}/' ${WORKDIR}/kms.conf.in > ${WORKDIR}/kms.conf
}

do_configure:append:use-mainline-bsp() {
    echo "QT_QPA_EGLFS_KMS_ATOMIC=1" >> ${WORKDIR}/defaults
    echo "QT_QPA_EGLFS_KMS_CONFIG=/etc/kms.conf" >> ${WORKDIR}/defaults
    sed -e 's/@DEVICE@/${DRI_DEVICE}/' ${WORKDIR}/kms.conf.in > ${WORKDIR}/kms.conf
}

do_install:append() {
    if [ -e ${WORKDIR}/kms.conf ]; then
        install -m 0644 ${WORKDIR}/kms.conf ${D}${sysconfdir}/
    fi
}

do_configure:append:mx8mm() {
    # QtWebEngine screen tearing issues with imx8mm (QTBUG-80665)
    echo "QTWEBENGINE_DISABLE_GPU_THREAD=1" >> ${WORKDIR}/defaults
}
