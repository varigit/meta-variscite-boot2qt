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

BBMASK += "\
    meta-freescale/dynamic-layers/qt5-layer/recipes-qt/qt5 \
"

IMAGE_FSTYPES += "wic"

QBSP_IMAGE_CONTENT ?= "\
    ${IMAGE_LINK_NAME}.img \
    ${IMAGE_LINK_NAME}.conf \
    "

# Use gstreamer 1.14 from meta-freescale
PREFERRED_VERSION_gstreamer1.0 ?= "1.14.imx"
PREFERRED_VERSION_gstreamer1.0-plugins-base ?= "1.14.imx"
PREFERRED_VERSION_gstreamer1.0-plugins-good ?= "1.14.imx"
PREFERRED_VERSION_gstreamer1.0-plugins-bad ?= "1.14.imx"
PREFERRED_VERSION_gstreamer1.0-plugins-ugly ?= "1.14.4"
PREFERRED_VERSION_gstreamer1.0-libav ?= "1.14.0"

MACHINE_GSTREAMER_1_0_PLUGIN_append_imxgpu = " imx-gst1.0-plugin"

MACHINE_EXTRA_INSTALL_append_mx8 = "${@bb.utils.contains('DISTRO_FEATURES', 'vulkan', 'libvulkan-imx', '', d)}"
