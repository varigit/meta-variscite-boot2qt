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

DESCRIPTION = "Qt Installer Framework"
LICENSE = "The-Qt-Company-Commercial"
LIC_FILES_CHKSUM = "file://${BOOT2QTBASE}/licenses/The-Qt-Company-Commercial;md5=213dc233cc25f71b1447fbe95ec90adf"

inherit bin_package native

do_unpack[depends] += "p7zip-native:do_populate_sysroot"

SRC_URI = "http://download.qt.io/development_releases/installer-framework/${PV}/installer-framework-build-stripped-${PV}-linux-x64.7z"

SRC_URI[md5sum] = "68b7c1f761ca0dba18f1d165d66005d6"
SRC_URI[sha256sum] = "c2eb769351025e0c7df2882116390fffaf958368f873a2abab99e37caee0a498"

S = "${WORKDIR}/ifw-pkg"

do_install() {
    install -d ${D}${bindir}
    install -m 0755 -t ${D}${bindir} ${S}/bin/*
}

INSANE_SKIP_${PN} += "already-stripped"
