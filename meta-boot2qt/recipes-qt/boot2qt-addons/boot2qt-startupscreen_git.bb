############################################################################
##
## Copyright (C) 2022 The Qt Company Ltd.
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

DESCRIPTION = "Boot to Qt Startup Screen"
LICENSE = "BSD-3-Clause | The-Qt-Company-Commercial"
LIC_FILES_CHKSUM = "file://main.cpp;md5=5c11ee2d9fe17c24e80b866d1b758458;beginline=1;endline=49"

inherit qt6-cmake systemd
require recipes-qt/qt6/qt6-git.inc

QT_GIT = "git://codereview.qt-project.org"
QT_GIT_PROTOCOL = "http"
QT_GIT_PROJECT = "qt-apps"
QT_MODULE = "boot2qt-demos"
QT_MODULE_BRANCH = "dev"

SRC_URI += "\
    file://startupscreen.service \
"

DEPENDS += "qtbase qtdeclarative qtdeclarative-native"
RDEPENDS:${PN} = "qtdeviceutilities"

S = "${WORKDIR}/git/startupscreen"

do_install:append() {
    install -m 0755 -d ${D}${systemd_unitdir}/system
    install -m 0644 ${WORKDIR}/startupscreen.service ${D}${systemd_unitdir}/system/
}


SYSTEMD_SERVICE:${PN} = "startupscreen.service"

SRCREV = "e65304f19ee63366fb37c36cd8d8b1067393b3ae"
