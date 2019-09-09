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

inherit populate_b2qt_sdk populate_sdk_qt5_base abi-arch siteinfo

SDK_MKSPEC_DIR = "${SDK_OUTPUT}${SDKTARGETSYSROOT}${libdir}/${QT_DIR_NAME}/mkspecs"
NATIVE_SDK_MKSPEC_DIR = "${SDK_OUTPUT}${SDKPATHNATIVE}${libdir}/${QT_DIR_NAME}/mkspecs"
SDK_MKSPEC = "devices/linux-oe-generic-g++"
SDK_DEVICE_PRI = "${SDK_MKSPEC_DIR}/qdevice.pri"
MACHINE_CMAKE = "${SDK_OUTPUT}${SDKPATHNATIVE}${datadir}/cmake/OEToolchainConfig.cmake.d/${MACHINE}.cmake"

create_sdk_files_append () {
    # Create the toolchain user's generic device mkspec
    install -d ${SDK_MKSPEC_DIR}/${SDK_MKSPEC}
    cat > ${SDK_MKSPEC_DIR}/${SDK_MKSPEC}/qmake.conf <<EOF
include(../common/linux_device_pre.conf)
exists(../../oe-device-extra.pri):include(../../oe-device-extra.pri)
include(../common/linux_device_post.conf)
load(qt_config)
EOF

    cat > ${SDK_MKSPEC_DIR}/${SDK_MKSPEC}/qplatformdefs.h <<EOF
#include "../../linux-g++/qplatformdefs.h"
EOF

    # Fill in the qdevice.pri file which will be used by the device mkspec
    echo "MACHINE = ${MACHINE}" > ${SDK_DEVICE_PRI}
    echo "CROSS_COMPILE = \$\$[QT_HOST_PREFIX]${bindir_nativesdk}/${TARGET_SYS}/${TARGET_PREFIX}" >> ${SDK_DEVICE_PRI}
    echo "QMAKE_CFLAGS *= ${TARGET_CC_ARCH}" >> ${SDK_DEVICE_PRI}
    echo "QMAKE_CXXFLAGS *= ${TARGET_CC_ARCH}" >> ${SDK_DEVICE_PRI}
    echo "QMAKE_LFLAGS *= ${TARGET_CC_ARCH} ${TARGET_LDFLAGS}" >> ${SDK_DEVICE_PRI}

    # Move FORTIFY_SOURCE to release flags
    if [ -n "${lcl_maybe_fortify}" ]; then
        sed -i -e 's/${lcl_maybe_fortify}//' ${SDK_DEVICE_PRI}
        echo "QMAKE_CFLAGS_RELEASE *= ${lcl_maybe_fortify}" >> ${SDK_DEVICE_PRI}
        echo "QMAKE_CXXFLAGS_RELEASE *= ${lcl_maybe_fortify}" >> ${SDK_DEVICE_PRI}
        echo "QMAKE_LFLAGS_RELEASE *= ${lcl_maybe_fortify}" >> ${SDK_DEVICE_PRI}
    fi

    # Setup qt.conf to point at the device mkspec by default
    qtconf=${SDK_OUTPUT}/${SDKPATHNATIVE}${OE_QMAKE_PATH_HOST_BINS}/qt.conf
    echo 'HostSpec = linux-g++' >> $qtconf
    echo 'TargetSpec = ${SDK_MKSPEC}' >> $qtconf

    # Update correct host_build ARCH and ABI to mkspecs/qconfig.pri
    QT_ARCH=$(grep QT_ARCH ${NATIVE_SDK_MKSPEC_DIR}/qconfig.pri | tail -1)
    QT_BUILDABI=$(grep QT_BUILDABI ${NATIVE_SDK_MKSPEC_DIR}/qconfig.pri | tail -1)

    sed -e "0,/QT_ARCH/s/^.*QT_ARCH.*/$QT_ARCH/" \
        -e "0,/QT_BUILDABI/s/^.*QT_BUILDABI.*/$QT_BUILDABI/" \
        -i ${SDK_MKSPEC_DIR}/qconfig.pri

    create_qtcreator_configure_script

    # Link /etc/resolv.conf is broken in the toolchain sysroot, remove it
    rm -f ${SDK_OUTPUT}${SDKTARGETSYSROOT}${sysconfdir}/resolv.conf

    # Create and add cmake toolchain file
    echo "set(CMAKE_SYSROOT ${SDKTARGETSYSROOT})" > ${MACHINE_CMAKE}
    echo "set(CMAKE_PREFIX_PATH ${SDKTARGETSYSROOT}${OE_QMAKE_PATH_LIBS}/cmake)" >> ${MACHINE_CMAKE}
    echo "set(compiler_flags \"${TARGET_CC_ARCH}\")" >> ${MACHINE_CMAKE}
    echo "set(CMAKE_C_COMPILER_ARG1 \"\${compiler_flags}\")" >> ${MACHINE_CMAKE}
    echo "set(CMAKE_CXX_COMPILER_ARG1 \"\${compiler_flags}\")" >> ${MACHINE_CMAKE}
    echo "set(OE_QMAKE_PATH_EXTERNAL_HOST_BINS ${SDKPATHNATIVE}${OE_QMAKE_PATH_HOST_BINS})" >> ${MACHINE_CMAKE}
}

create_sdk_files_append_sdkmingw32 () {
    echo "set(OE_QMAKE_BIN_SUFFIX .exe)" >> ${MACHINE_CMAKE}
}

create_qtcreator_configure_script () {
    # add qtcreator configuration script
    install -m 0755 ${BOOT2QTBASE}/files/configure-qtcreator.sh ${SDK_OUTPUT}/${SDKPATH}
    sed -i -e '/^CONFIG=/c\CONFIG="${SDKPATH}/environment-setup-${REAL_MULTIMACH_TARGET_SYS}"' ${SDK_OUTPUT}/${SDKPATH}/configure-qtcreator.sh
    sed -i -e '/^ABI=/c\ABI="${ABI}-linux-poky-elf-${SITEINFO_BITS}bit"' ${SDK_OUTPUT}/${SDKPATH}/configure-qtcreator.sh
}

create_qtcreator_configure_script_sdkmingw32 () {
    # no script available for mingw
    true
}
