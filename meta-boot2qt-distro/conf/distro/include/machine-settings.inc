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

MACHINE_FAMILY ??= "empty"
MACHINE_FAMILY:imx = "fsl"
MACHINE_FAMILY:intel-x86-common = "intel"
MACHINE_FAMILY:qemuall = "qemu"
MACHINE_FAMILY:rpi = "raspberrypi"
MACHINE_FAMILY:tegra = "jetson"

# Toradex has no overrides that would distinguish them from other nxp boards
MACHINE_FAMILY:apalis-imx6 = "toradex"
MACHINE_FAMILY:apalis-imx8 = "toradex"
MACHINE_FAMILY:colibri-imx6 = "toradex"
MACHINE_FAMILY:colibri-imx6ull = "toradex"
MACHINE_FAMILY:colibri-imx7 = "toradex"
MACHINE_FAMILY:colibri-imx7-emmc = "toradex"
MACHINE_FAMILY:colibri-imx8x = "toradex"
MACHINE_FAMILY:verdin-imx8mm = "toradex"
MACHINE_FAMILY:verdin-imx8mp = "toradex"

# Variscite
MACHINE_FAMILY:imx8mm-var-dart = "variscite"
MACHINE_FAMILY:imx8mn-var-som = "variscite"
MACHINE_FAMILY:imx8mp-var-dart = "variscite"
MACHINE_FAMILY:imx8mq-var-dart = "variscite"
MACHINE_FAMILY:imx8qm-var-som = "variscite"
MACHINE_FAMILY:imx8qxp-var-som = "variscite"
MACHINE_FAMILY:imx8qxpb0-var-som = "variscite"

include conf/distro/include/${MACHINE_FAMILY}.inc
include conf/distro/include/${MACHINE}.inc

# prefer .inc, but include .conf for backwards compatibility
include conf/distro/include/${MACHINE}.conf
