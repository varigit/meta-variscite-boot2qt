############################################################################
##
## Copyright (C) 2020 The Qt Company Ltd.
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
LICENSE = "BSD | The-Qt-Company-Commercial"
LIC_FILES_CHKSUM = "file://${BOOT2QTBASE}/licenses/The-Qt-Company-Commercial;md5=c8b6dd132d52c6e5a545df07a4e3e283"

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

DEPENDS += "qtbase qtdeclarative qtdeclarative-native qtquickcontrols2"

S = "${WORKDIR}/git/startupscreen"

do_install_append() {
    install -m 0755 -d ${D}${systemd_unitdir}/system
    install -m 0644 ${WORKDIR}/startupscreen.service ${D}${systemd_unitdir}/system/
}


SYSTEMD_SERVICE_${PN} = "startupscreen.service"

SRCREV = "bb9fdbf7401e552bac36132a34512fe3a075ef41"
