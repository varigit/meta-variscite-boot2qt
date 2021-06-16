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

DESCRIPTION = "Qt Debug Bridge Daemon"
SECTION = "devel"
LICENSE = "GPL-3.0 | The-Qt-Company-Commercial"
LIC_FILES_CHKSUM = "file://LICENSE.GPL3;md5=d32239bcb673463ab874e80d47fae504"

inherit features_check
inherit qt6-cmake
require recipes-qt/qt6/qt6-git.inc

QT_GIT_PROJECT = "qt-apps"
QT_MODULE_BRANCH = "master"

SRC_URI += "\
    file://b2qt-gadget-network.sh \
    file://defaults \
    file://qdbd.service \
    file://qdbd-init.sh \
    file://0001-CMake-adapt-to-new-CMake-API.patch \
"

SRCREV = "72bd22db9f72c4d93774c79cae0760bdc39ce0de"
PV = "1.3.0+git${SRCPV}"

REQUIRED_DISTRO_FEATURES = "systemd"
DEPENDS = "qtbase qtdeclarative qtdeclarative-native"
RRECOMMENDS_${PN} += "kernel-module-usb-f-fs kernel-module-usb-f-rndis"
EXTRA_OECMAKE += "-DDAEMON_ONLY=ON"

do_install_append() {
    install -m 0755 ${WORKDIR}/b2qt-gadget-network.sh ${D}${bindir}/

    install -m 0755 ${WORKDIR}/qdbd-init.sh ${D}${bindir}/

    install -m 0755 -d ${D}${systemd_unitdir}/system
    install -m 0644 ${WORKDIR}/qdbd.service ${D}${systemd_unitdir}/system/

    install -m 0755 -d ${D}${sysconfdir}/default
    install -m 0644 ${WORKDIR}/defaults ${D}${sysconfdir}/default/qdbd
}

SYSTEMD_SERVICE_${PN} = "qdbd.service"

inherit systemd
