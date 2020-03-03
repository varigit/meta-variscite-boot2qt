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

include conf/distro/include/fsl.inc

FSL_EULA_FILE := "${COREBASE}/../meta-fsl-bsp-release/imx/EULA.txt"

DISTRO_FEATURES_remove = "vulkan"

PREFERRED_PROVIDER_virtual/bootloader_imx = "u-boot-imx"
PREFERRED_VERSION_linux-libc-headers_imx ?= "4.14"
PREFERRED_VERSION_gstreamer1.0-plugins-base = "1.14.4.imx"
PREFERRED_VERSION_gstreamer1.0-plugins-bad  = "1.14.4.imx"
PREFERRED_VERSION_gstreamer1.0-plugins-good = "1.14.4.imx"
PREFERRED_VERSION_gstreamer1.0              = "1.14.4.imx"

BBMASK += "\
    meta-boot2qt/meta-fsl-extras/recipes/u-boot/u-boot-toradex_%.bbappend \
    meta-freescale/recipes-graphics/drm/libdrm_%.bbappend \
    imx/meta-bsp/recipes-browser \
    imx/meta-sdk/recipes-fsl/fsl-rc-local \
    imx/meta-sdk/recipes-fsl/images \
    imx/meta-sdk/recipes-fsl/packagegroup/packagegroup-fsl-gstreamer1.0.bbappend \
    imx/meta-sdk/recipes-fsl/packagegroup/packagegroup-fsl-tools-gpu.bbappend \
    imx/meta-sdk/recipes-fsl/packagegroup/packagegroup-fsl-tools-testapps.bbappend \
    imx/meta-sdk/recipes-graphics/devil \
    imx/meta-sdk/dynamic-layers/qt5-layer \
    "

KERNEL_MODULE_PACKAGE_SUFFIX ?= "-${@d.getVar('KERNEL_VERSION').replace('_','-')}"

WKS_FILE = "imx8-uboot-bootpart.wks.in"
WIC_CREATE_EXTRA_ARGS = "--no-fstab-update"
WKS_FILE_DEPENDS += "imx-boot"

IMAGE_BOOT_FILES = "\
    Image \
    fsl-*.dtb \
    "
