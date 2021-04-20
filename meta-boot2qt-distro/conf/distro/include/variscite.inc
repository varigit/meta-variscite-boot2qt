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

BBMASK += " \
    meta-variscite-fslc/recipes-fsl/packagegroups/packagegroup-fsl-tools-gpu.bbappend \
    meta-variscite-fslc/recipes-fsl/packagegroups/packagegroup-fsl-tools-testapps.bbappend \
    "

IMAGE_INSTALL_append = " \
    alsa-utils \
    fbset \
    can-utils \
    coreutils \
    cryptodev-module \
    cryptodev-tests \
    dosfstools \
    e2fsprogs-mke2fs \
    ethtool \
    evtest \
    iperf3 \
    linuxptp \
    memtester \
    minicom \
    mmc-utils \
    mtd-utils-ubifs \
    nano \
    ntpdate \
    pciutils \
    ptpd \
    tar \
    udev-extraconf \
    usbutils \
    util-linux \
    v4l-utils \
    "

# let's save space
RDEPENDS_packagegroup-b2qt-embedded-base_remove_pn-packagegroup-b2qt-embedded-base = "linux-firmware"
