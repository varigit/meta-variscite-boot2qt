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

IMAGE_FSTYPES += "wic"
WKS_FILE = "sdimage-bootpart.wks"
WIC_CREATE_EXTRA_ARGS = "--no-fstab-update"
WKS_FILE_DEPENDS += "u-boot optee-os"

IMAGE_BOOT_FILES = "\
    Image \
    r*.dtb \
    "

QBSP_IMAGE_CONTENT = "\
    ${IMAGE_LINK_NAME}.img \
    ${IMAGE_LINK_NAME}.conf \
    bl2-${MACHINE}.srec \
    bl31-${MACHINE}.srec \
    tee-${MACHINE}.srec \
    bootparam_sa0.srec \
    cert_header_sa6.srec \
    u-boot-elf-${MACHINE}.srec \
    "

BOOT_SPACE = "32768"

# uncomment following if using the evaluation drivers
#DISTRO_FEATURES_append = " use_eva_pkg"

MACHINE_FEATURES_append = " gsx multimedia"

MULTI_PROVIDER_WHITELIST += "virtual/libgl virtual/egl virtual/libgles1 virtual/libgles2 virtual/libgbm"

#DISTRO_FEATURES_append = " pam"
PREFERRED_PROVIDER_virtual/libgles1 = ""
PREFERRED_PROVIDER_virtual/libgles2 = "gles-user-module"
PREFERRED_PROVIDER_virtual/egl = "libegl"
PREFERRED_PROVIDER_virtual/libgl = ""
PREFERRED_PROVIDER_virtual/mesa = ""
PREFERRED_PROVIDER_libgbm = "libgbm"
PREFERRED_PROVIDER_libgbm-dev = "libgbm"
PREFERRED_PROVIDER_virtual/libgbm = "libgbm"
BBMASK += "mesa-gl"

# internal copy of R-Car_Series_Evaluation_Software_Packages used for CI
FILESEXTRAPATHS_append = "${BSPDIR}/sources/renesas-rcar-gen3/${PN}:"

BBMASK += "\
    meta-linaro/meta-optee/recipes-security/optee \
    meta-rcar-gen3/recipes-core/packagegroups \
    "
