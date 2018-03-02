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

PREFERRED_PROVIDER_libdrm-tegra = "libdrm-tegra"

# use mmc0
ROOTFS_DEVICE = "mmcblk1p1"

INITRAMFS_MAXSIZE = "165888"
IMAGE_CLASSES += "image_types_tegra"
IMAGE_FSTYPES += "tegraflash"
IMAGE_ROOTFS_ALIGNMENT = "1024"
UBOOT_SUFFIX = "bin"

QBSP_IMAGE_CONTENT = "\
    ${IMAGE_LINK_NAME}.img \
    ${IMAGE_LINK_NAME}.conf \
    "
