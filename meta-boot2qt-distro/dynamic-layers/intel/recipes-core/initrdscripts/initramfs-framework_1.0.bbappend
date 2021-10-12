############################################################################
##
## Copyright (C) 2019 The Qt Company Ltd.
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

FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += "\
    file://rtsx_pci_sdmmc \
    file://network \
    "

do_install:append() {
    install -m 0755 ${WORKDIR}/rtsx_pci_sdmmc ${D}/init.d/20-rtsx_pci_sdmmc
    install -m 0755 ${WORKDIR}/network ${D}/init.d/30-network
}

PACKAGES += "\
    initramfs-module-rtsx-pci-sdmmc \
    initramfs-module-r8169 \
    "

SUMMARY:initramfs-module-rtsx-pci-sdmmc = "initramfs support for rtsx_pci_sdmmc"
RDEPENDS:initramfs-module-rtsx-pci-sdmmc = "${PN}-base"
FILES:initramfs-module-rtsx-pci-sdmmc = "/init.d/20-rtsx_pci_sdmmc"

SUMMARY:initramfs-module-r8169 = "initramfs support for Realtek LAN driver"
RDEPENDS:initramfs-module-r8169 = "${PN}-base"
FILES:initramfs-module-r8169 = "/init.d/30-network"
