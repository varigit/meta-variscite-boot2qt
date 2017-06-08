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

FILESEXTRAPATHS_append := "${THISDIR}/${PN}:"
SRC_URI += "\
    file://0001-Change-typedef-for-EGLNativeDisplayType.patch \
    file://99-fb.rules \
    file://pvr.service \
    "

inherit systemd

SYSTEMD_SERVICE_${PN} = "pvr.service"

# for supporting weston
PROVIDES += "virtual/mesa"

do_install_append() {
    install -d ${D}${base_libdir}/udev/rules.d
    install -m 0644 ${WORKDIR}/99-fb.rules ${D}${base_libdir}/udev/rules.d

    install -d ${D}${systemd_unitdir}/system
    install -m 0644 ${WORKDIR}/pvr.service ${D}${systemd_unitdir}/system

    install -d ${D}${bindir}
    install -m 0755 ${D}${sysconfdir}/init.d/rc.pvr ${D}${bindir}
}

FILES_${PN} += "\
    ${base_libdir}/udev/rules.d/*.rules \
    ${systemd_unitdir}/system/pvr.service \
    "

RRECOMMENDS_${PN} += "ti-sgx-ddk-km"

INSANE_SKIP_${PN} += "already-stripped"
