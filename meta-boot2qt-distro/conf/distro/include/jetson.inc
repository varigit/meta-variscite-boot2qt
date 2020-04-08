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

INITRAMFS_MAXSIZE = "165888"
IMAGE_CLASSES += "image_types_tegra"
IMAGE_FSTYPES += "tegraflash"
IMAGE_ROOTFS_ALIGNMENT = "1024"
UBOOT_SUFFIX = "bin"

QBSP_IMAGE_CONTENT = "\
    ${IMAGE_LINK_NAME}.img \
    ${IMAGE_LINK_NAME}.conf \
    ${IMAGE_LINK_NAME}.flasher.tar.gz \
    "

# NVIDIA's Vulkan support is for X only
DISTRO_FEATURES_remove = "vulkan"

# https://github.com/madisongh/meta-tegra/issues/236
KERNEL_MODULE_AUTOLOAD_remove = "tegra-udrm"
KERNEL_MODULE_PROBECONF_remove = "tegra-udrm"
module_conf_tegra-udrm = ""

NVIDIA_DEVNET_MIRROR ?= "file://${BSPDIR}/sources/nvidia-devnet-mirror"
NVIDIA_DEVNET_MIRROR[vardepsexclude] = "BSPDIR"
