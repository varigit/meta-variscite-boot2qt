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

DESCRIPTION = "Qt Installer Framework"
LICENSE = "The-Qt-Company-Commercial"
LIC_FILES_CHKSUM = "file://${BOOT2QTBASE}/licenses/The-Qt-Company-Commercial;md5=213dc233cc25f71b1447fbe95ec90adf"

inherit bin_package native

do_unpack[depends] += "p7zip-native:do_populate_sysroot"

SRC_URI = "https://download.qt.io/development_releases/installer-framework/${PV}/installer-framework-Linux-RHEL_7_4-GCC-Linux-RHEL_7_4-X86_64.7z"

SRC_URI[md5sum] = "8b87aef981dc7205d8574c486401a7c2"
SRC_URI[sha256sum] = "212094b446bad04629045c08cb274eb7e9a4cc5c1ddd5c7c8fcbfe10af783e1b"

S = "${WORKDIR}"

do_install() {
    install -d ${D}${bindir}
    install -m 0755 -t ${D}${bindir} ${S}/bin/*
}

INSANE_SKIP_${PN} += "already-stripped"
