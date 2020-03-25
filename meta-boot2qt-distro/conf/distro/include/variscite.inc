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

include conf/distro/include/fsl.inc

BBMASK += " \
    meta-variscite-fslc/dynamic-layers/qt5-layer \
    "

# unwanted B2QT demos
BOOT2QT_DEMOS_remove = "boot2qt-demo-mediaplayer"

DISTRO_FEATURES_append = " pulseaudio"
DISTRO_FEATURES_remove = "vulkan"

IMAGE_FSTYPES_remove = "ext3"
IMAGE_FSTYPES += "multiubi tar.gz"

IMAGE_INSTALL_append = " \
    alsa-utils \
    boot2qt-demo-camera \
    can-utils \
    mtd-utils \
    mtd-utils-ubifs \
    dosfstools \
    e2fsprogs-mke2fs \
    evtest \
    iperf3 \
    pciutils \
    pulseaudio-misc \
    pulseaudio-server \
    tar \
    udev-extraconf \
    usbutils \
    "

# let's save space
RDEPENDS_packagegroup-b2qt-embedded-base_remove_pn-packagegroup-b2qt-embedded-base = "linux-firmware"
