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

DESCRIPTION = "QtSimulator"
LICENSE = "The-Qt-Company-DCLA-2.1"
LIC_FILES_CHKSUM = "file://src/simulator/simulatorglobal.h;md5=3daa1a609195439d0292259a74c7d615;beginline=1;endline=20"

inherit qt5-module

SRC_URI = " \
    git://codereview.qt-project.org/tqtc-boot2qt/qtsimulator;branch=${BRANCH};protocol=ssh \
    file://emulatorproxyd.sh \
    file://emulatorproxy.service \
    file://emulator-hostname.sh \
    file://emulator \
    "

SRCREV = "f98633ebee7dbce79c00fbfec86537c6330e2b5f"
BRANCH = "master"

S = "${WORKDIR}/git"

DEPENDS = "qtbase"
RRECOMMENDS_${PN} += "${PN}-tools"

# Proxy daemon for QtSimulator
do_install_append() {
    install -m 0755 -d ${D}${sysconfdir}/init.d
    install -m 0755 ${WORKDIR}/emulatorproxyd.sh ${D}${sysconfdir}/init.d/

    install -m 0755 -d ${D}${systemd_unitdir}/system
    install -m 0644 ${WORKDIR}/emulatorproxy.service ${D}${systemd_unitdir}/system/

    install -m 0755 -d ${D}${sysconfdir}/profile.d
    install -m 0644 ${WORKDIR}/emulator-hostname.sh ${D}${sysconfdir}/profile.d/

    install -m 0755 -d ${D}${sysconfdir}/default
    install -m 0644 ${WORKDIR}/emulator ${D}${sysconfdir}/default/
}

INITSCRIPT_NAME = "emulatorproxyd.sh"
INITSCRIPT_PARAMS = "defaults 97 10"

SYSTEMD_SERVICE_${PN} = "emulatorproxy.service"

inherit update-rc.d systemd
