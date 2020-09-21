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

inherit populate_b2qt_sdk populate_sdk_qt6_base abi-arch siteinfo

create_sdk_files_append () {

    create_qtcreator_configure_script

    # Link /etc/resolv.conf is broken in the toolchain sysroot, remove it
    rm -f ${SDK_OUTPUT}${SDKTARGETSYSROOT}${sysconfdir}/resolv.conf
}

create_qtcreator_configure_script () {
    # add qtcreator configuration script
    install -m 0755 ${BOOT2QTBASE}/files/configure-qtcreator.sh ${SDK_OUTPUT}/${SDKPATH}
    sed -i -e '/^CONFIG=/c\CONFIG="${SDKPATH}/environment-setup-${REAL_MULTIMACH_TARGET_SYS}"' ${SDK_OUTPUT}/${SDKPATH}/configure-qtcreator.sh
    sed -i -e '/^ABI=/c\ABI="${ABI}-linux-poky-elf-${SITEINFO_BITS}bit"' ${SDK_OUTPUT}/${SDKPATH}/configure-qtcreator.sh
    sed -i -e '/^MACHINE=/c\MACHINE="${MACHINE}"' ${SDK_OUTPUT}/${SDKPATH}/configure-qtcreator.sh
}

create_qtcreator_configure_script_sdkmingw32 () {
    # no script available for mingw
    true
}
