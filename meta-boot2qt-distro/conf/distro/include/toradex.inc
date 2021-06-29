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

include conf/distro/include/fsl.inc

# include file from meta-toradex-nxp
include conf/machine/include/${MACHINE}.inc

PREFERRED_PROVIDER_virtual/dtb_use-nxp-bsp = "device-tree-overlays"

QBSP_IMAGE_CONTENT += "\
    ${IMAGE_LINK_NAME}.tezi.tar \
"

BBMASK += "\
    meta-toradex-nxp/backports \
    meta-toradex-nxp/recipes-bsp/u-boot/u-boot-tools_%.bbappend \
"

# Use Toradex defined names
DEPLOY_CONF_NAME = "Toradex ${MACHINE_NAME}"

ATF_PLATFORM_mx8qm = "imx8qm"
ATF_PLATFORM_mx8x = "imx8qx"
ATF_PLATFORM_mx8mm = "imx8mm"
ATF_PLATFORM_mx8mp = "imx8mp"
IMX_BOOT_SOC_TARGET_mx8qm = "iMX8QM"
IMX_BOOT_SOC_TARGET_mx8x = "iMX8QX"
IMX_BOOT_SOC_TARGET_mx8mm = "iMX8MM"
IMX_BOOT_SOC_TARGET_mx8mp = "iMX8MP"

GPULESS_FEATURES = "wayland opengl vulkan"
GPULESS_FEATURES_imxgpu = ""
DISTRO_FEATURES_remove = "${GPULESS_FEATURES}"

# remove support for 256MB version colibri-imx6ull in tezi image, since image will be too large for it.
TORADEX_PRODUCT_IDS_remove_colibri-imx6ull = "0036"
