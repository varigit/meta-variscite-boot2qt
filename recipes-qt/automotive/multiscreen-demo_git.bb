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

DESCRIPTION = "Multiscreen Demo"
LICENSE = "GPLv3 | The-Qt-Company-DCLA-2.1"
LIC_FILES_CHKSUM = "file://LICENSE.GPL3-EXCEPT;md5=763d8c535a234d9a3fb682c7ecb6c073"

inherit qt5-module systemd
require recipes-qt/qt5/qt5-git.inc

QT_GIT = "git://code.qt.io/qt-apps"
QT_MODULE_BRANCH = "master"

SRC_URI += "git://github.com/qtproject/qt-apps-demo-assets;protocol=git;name=assets;destsuffix=git/demo-assets"

SRCREV_multiscreen = "f4cd6b9667b4649b4ef8b4bb645850b05aceebde"
SRCREV_assets = "0d47d21f082d6c9e355a55809ebd38a31ea02264"

SRCREV_FORMAT = "multiscreen_assets"
SRCREV = "${SRCREV_multiscreen}"

DEPENDS = "qtbase qtdeclarative qt3d"
RDEPENDS_${PN} = "qtapplicationmanager qtivi qtvirtualkeyboard"

EXTRA_QMAKEVARS_PRE += "INSTALL_PREFIX=/opt"

do_install_append() {
    install -m 0755 ${S}/start.sh ${D}/opt/automotivedemo/

    install -d ${D}${systemd_system_unitdir}
    install -m 0644 ${S}/scripts/automotivedemo.service ${D}${systemd_system_unitdir}/
}

FILES_${PN} += "\
    /opt/automotivedemo \
    "

SYSTEMD_SERVICE_${PN} = "automotivedemo.service"
SYSTEMD_AUTO_ENABLE = "disable"
