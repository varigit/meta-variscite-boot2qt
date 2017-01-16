############################################################################
##
## Copyright (C) 2016 The Qt Company Ltd.
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
LICENSE = "The-Qt-Company-DCLA-2.1"
LIC_FILES_CHKSUM = "file://qdbd/main.cpp;md5=37093977d3f09e6366def8955c8c71e6;beginline=1;endline=18"

inherit qmake5

SRC_URI = "git://codereview.qt-project.org/tqtc-boot2qt/qdb;branch=${BRANCH};protocol=ssh \
           file://defaults \
           file://qdbd.service \
           file://qdbd-init.sh \
          "

SRCREV = "c3f54cedb1fc2805eb21b2499514284941445e85"
BRANCH = "5.8"
PV = "1.0.0+git${SRCPV}"

DEPENDS = "qtbase"
RRECOMMENDS_${PN} += "kernel-module-usb-f-fs kernel-module-usb-f-rndis"

S = "${WORKDIR}/git"

EXTRA_QMAKEVARS_PRE = "CONFIG+=daemon_only"

do_install_append() {
    install -m 0755 ${WORKDIR}/qdbd-init.sh ${D}${bindir}/
    install -m 0755 -d ${D}${sysconfdir}/init.d
    ln -s ${bindir}/qdbd-init.sh ${D}${sysconfdir}/init.d/

    install -m 0755 -d ${D}${systemd_unitdir}/system
    install -m 0644 ${WORKDIR}/qdbd.service ${D}${systemd_unitdir}/system/

    install -m 0755 -d ${D}${sysconfdir}/default
    install -m 0644 ${WORKDIR}/defaults ${D}${sysconfdir}/default/qdbd
}

INITSCRIPT_NAME = "qdbd-init.sh"
INITSCRIPT_PARAMS = "defaults 96"

SYSTEMD_SERVICE_${PN} = "qdbd.service"
# adbd is started by default instead of qdbd
SYSTEMD_AUTO_ENABLE = "disable"

inherit update-rc.d systemd
