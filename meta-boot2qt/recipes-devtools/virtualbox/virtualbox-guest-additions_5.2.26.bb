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

DESCRIPTION = "Kernel drivers for the VirtualBox guest additions"
LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://${WORKDIR}/VirtualBox-${PV}/COPYING;md5=e197d5641bb35b29d46ca8c4bf7f2660"

inherit module

MACHINE_KERNEL_PR_append = "a"
PR = "${MACHINE_KERNEL_PR}"

SRC_URI = "http://download.virtualbox.org/virtualbox/${PV}/VirtualBox-${PV}.tar.bz2"

SRC_URI[md5sum] = "4e84cd1aecb67e3f59b3ee06292bb2d0"
SRC_URI[sha256sum] = "4debe583463be3917ac60ad76a31f6db27586423d86f1f53c060d70d5e70d467"

S = "${WORKDIR}/vbox"

export KERN_DIR="${STAGING_KERNEL_DIR}"
export KERN_VER="${KERNEL_VERSION}"
export KBUILD_VERBOSE="1"
export BUILD_TARGET_ARCH="${ARCH}"

do_compile() {
    ${WORKDIR}/VirtualBox-${PV}/src/VBox/Additions/linux/export_modules.sh ${WORKDIR}/vbox.tar.gz
    tar xf ${WORKDIR}/vbox.tar.gz -C ${WORKDIR}/vbox
    find ${WORKDIR}/vbox -name Makefile.include.header | xargs sed -i -e '/KERN_DIR :=/d'

    oe_runmake all || die "make failed"
}

do_install() {
    install -m 0755 -d ${D}/lib/modules/${KERNEL_VERSION}/kernel/drivers/vbox
    install -m 0644 vboxsf.ko ${D}/lib/modules/${KERNEL_VERSION}/kernel/drivers/vbox
    install -m 0644 vboxguest.ko ${D}/lib/modules/${KERNEL_VERSION}/kernel/drivers/vbox
    install -m 0644 vboxvideo.ko ${D}/lib/modules/${KERNEL_VERSION}/kernel/drivers/vbox
}

PKG_${PN} = "kernel-module-vbox"
