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

include conf/distro/include/fsl.inc

DEPLOY_CONF_NAME:imx8mp-var-dart = "Variscite DART-MX8M-PLUS"

# Set a more generic tuning for code reuse across parts
DEFAULTTUNE:mx8-nxp-bsp:b2qt     ?= "armv8a-crc-crypto"
DEFAULTTUNE:mx8m-nxp-bsp:b2qt    ?= "armv8a-crc-crypto"
DEFAULTTUNE:mx8qxp-nxp-bsp:b2qt  ?= "armv8a-crc-crypto"
DEFAULTTUNE:mx8x-nxp-bsp:b2qt    ?= "armv8a-crc-crypto"

BBMASK += " \
    meta-boot2qt/meta-boot2qt-distro/recipes-kernel/linux-firmware \
    "

# let's save space
RDEPENDS:packagegroup-b2qt-embedded-base:remove:pn-packagegroup-b2qt-embedded-base = "linux-firmware"
