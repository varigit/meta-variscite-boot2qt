############################################################################
##
## Copyright (C) 2017 The Qt Company Ltd.
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

LICENSE = "PSFv2"

LIC_FILES_CHKSUM = "file://LICENSE.txt;md5=4b8a9367e6bb2acb6f26dc08654f6ee5"

do_unpack[depends] += "p7zip-native:do_populate_sysroot"

DEPENDS = "unzip-native"

inherit bin_package nativesdk python3-dir

PV = "3.5.2"

S = "${WORKDIR}"

do_install() {
    install -d ${D}${includedir}/${PYTHON_DIR}
    install -m 0644 ${S}/include/* ${D}${includedir}/${PYTHON_DIR}

    install -d ${D}${libdir}
    install -m 0644 ${S}/libs/*.a ${D}${libdir}

    install -d ${D}${bindir}
    install -m 0644 ${S}/python.exe ${D}${bindir}
    install -m 0644 ${S}/python35.dll ${D}${bindir}

    install -d ${D}${libdir}/${PYTHON_DIR}
    unzip ${S}/python35.zip -d ${D}${libdir}/${PYTHON_DIR}
}
