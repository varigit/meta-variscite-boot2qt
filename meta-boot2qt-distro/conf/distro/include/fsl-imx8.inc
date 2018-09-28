############################################################################
##
## Copyright (C) 2018 The Qt Company Ltd.
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

RDEPENDS_gstreamer1.0-meta-base_remove_pn-gstreamer1.0-meta-base = " gstreamer1.0-plugins-good-souphttpsrc"
RDEPENDS_gstreamer1.0-meta-base_append_pn-gstreamer1.0-meta-base = " gstreamer1.0-plugins-good-soup"

BBMASK += "\
    meta-boot2qt-distro/recipes-connectivity/connman/connman_%.bbappend \
    meta-boot2qt/meta-fsl-extras/recipes/u-boot/u-boot-toradex_%.bbappend \
    meta-freescale/recipes-graphics/wayland/weston \
    meta-fsl-bsp-release/imx/meta-bsp/recipes-browser \
    meta-fsl-bsp-release/imx/meta-bsp/recipes-bsp/imx-test \
    meta-fsl-bsp-release/imx/meta-bsp/recipes-connectivity/bluez5 \
    meta-fsl-bsp-release/imx/meta-bsp/recipes-connectivity/connman \
    meta-fsl-bsp-release/imx/meta-bsp/recipes-connectivity/nfs-utils \
    meta-fsl-bsp-release/imx/meta-bsp/recipes-connectivity/wpa-supplicant \
    meta-fsl-bsp-release/imx/meta-bsp/recipes-core/systemd/systemd_%.bbappend \
    meta-fsl-bsp-release/imx/meta-bsp/recipes-devtools/gdb \
    meta-fsl-bsp-release/imx/meta-bsp/recipes-extended/logrotate \
    meta-fsl-bsp-release/imx/meta-bsp/recipes-graphics/opencv \
    meta-fsl-bsp-release/imx/meta-bsp/recipes-graphics/xorg-driver \
    meta-fsl-bsp-release/imx/meta-bsp/recipes-kernel/cryptodev \
    meta-fsl-bsp-release/imx/meta-bsp/recipes-multimedia/alsa \
    meta-fsl-bsp-release/imx/meta-bsp/recipes-multimedia/pulseaudio \
    meta-fsl-bsp-release/imx/meta-sdk/recipes-fsl/fsl-rc-local \
    meta-fsl-bsp-release/imx/meta-sdk/recipes-fsl/images \
    meta-fsl-bsp-release/imx/meta-sdk/recipes-fsl/packagegroup \
    meta-fsl-bsp-release/imx/meta-sdk/recipes-graphics/devil \
    meta-fsl-bsp-release/imx/meta-sdk/recipes-qt5/qt5 \
    "

KERNEL_MODULE_PACKAGE_SUFFIX ?= "-${@d.getVar('KERNEL_VERSION', True).replace('_','-')}"
EXTRA_OECONF_append_pn-gstreamer1.0-plugins-base = " --disable-introspection"

MACHINE_GSTREAMER_1_0_PLUGIN += "imx-gst1.0-plugin"

WKS_FILE = "imx8-uboot-bootpart.wks"
WIC_CREATE_EXTRA_ARGS = "--no-fstab-update"
WKS_FILE_DEPENDS += "imx-boot"

BOOT_CONFIG_MACHINE_pn-imx-boot = "${BOOT_NAME}-${UBOOT_CONFIG}.bin"

IMAGE_BOOT_FILES = "\
    Image \
    fsl-*.dtb \
    hdmitxfw.bin \
    "
