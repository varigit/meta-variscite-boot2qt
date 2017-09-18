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

SRCBRANCH = "linux_4.1.29"
SRCREV = "881845d84e3c2e58a00b9c36616203d748b7df0e"
LOCALVERSION = "-warp7"

FILESEXTRAPATHS_append := "${THISDIR}/${PN}:"
SRC_URI += " \
        file://0001-Fix-dev-hwrng-by-enabling-warp7-crypto-device.patch \
        "

do_configure_prepend() {
    echo "CONFIG_NAMESPACES=y"      >> ${B}/.config
    echo "CONFIG_FHANDLE=y"         >> ${B}/.config
    echo "CONFIG_USB_FUNCTIONFS=m"  >> ${B}/.config

    echo "CONFIG_MXC_CAMERA_OV2680_MIPI=m"              >> ${B}/.config
    echo "CONFIG_FB_MXC_TRULY_PANEL_TDO_ST7796H=y"      >> ${B}/.config
    echo "CONFIG_TOUCHSCREEN_SYNAPTICS_DSX_CORE=y"      >> ${B}/.config
    echo "CONFIG_TOUCHSCREEN_SYNAPTICS_DSX_RMI_DEV=y    >> ${B}/.config
    echo "CONFIG_TOUCHSCREEN_SYNAPTICS_DSX_FW_UPDATE=y  >> ${B}/.config
}
