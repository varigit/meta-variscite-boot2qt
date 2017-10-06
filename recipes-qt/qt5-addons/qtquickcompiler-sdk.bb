############################################################################
##
## Copyright (C) 2016 The Qt Company Ltd.
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

DESCRIPTION = "Qt Quick Compiler using prebuilt binaries from Qt SDK"
LICENSE = "The-Qt-Company-DCLA-2.1"
LIC_FILES_CHKSUM = "file://${QT_LICENSE};md5=80e06902b5f0e94ad0a78ee4f7fcb74b"

inherit allarch qmake5_paths

SRC_URI = "http://download.qt.io/development_releases/prebuilt/mingw_32/i686-4.9.2-release-posix-dwarf-rt_v3-rev1-runtime.7z"

SRC_URI[md5sum] = "a7d673c4ad8bcef9e464ea5386492cb3"
SRC_URI[sha256sum] = "f7e58b0fb1f5aa4c23eefdc60abb88cb642eaa272fb741dca23068c70ca86542"

S = "${WORKDIR}"

NATIVESDK_BINARY = "qtquickcompiler"
NATIVESDK_BINARY_mingw32 = "qtquickcompiler.exe"

do_install() {
    install -d ${D}${OE_QMAKE_PATH_ARCHDATA}/mkspecs/features
    install -m 0755 ${THISDIR}/qtquickcompiler-sdk/mkspecs/features/qtquickcompiler.prf ${D}${OE_QMAKE_PATH_ARCHDATA}/mkspecs/features
    install -d ${D}${OE_QMAKE_PATH_ARCHDATA}/cmake/Qt5QuickCompiler
    install -m 0644 ${THISDIR}/qtquickcompiler-sdk/lib/cmake/Qt5QuickCompiler/Qt5QuickCompilerConfig.cmake ${D}${OE_QMAKE_PATH_ARCHDATA}/cmake/Qt5QuickCompiler

    if [ "${PN}" = "qtquickcompiler-sdk-native" ]; then
        install -d ${D}${OE_QMAKE_PATH_BINS}
        install -m 0755 ${THISDIR}/qtquickcompiler-sdk/bin/qtquickcompiler ${D}${OE_QMAKE_PATH_BINS}
    elif [ "${PN}" = "nativesdk-qtquickcompiler-sdk" ]; then
        install -d ${D}${OE_QMAKE_PATH_BINS}
        install -m 0755 ${THISDIR}/qtquickcompiler-sdk/bin/${NATIVESDK_BINARY} ${D}${OE_QMAKE_PATH_BINS}
    fi

    # Use the EffectivePath instead of installation path
    sed -i -e 's|QT_HOST_BINS|QT_HOST_BINS/get|' ${D}${OE_QMAKE_PATH_ARCHDATA}/mkspecs/features/qtquickcompiler.prf
}

do_install_append_mingw32() {
    if [ "${PN}" = "nativesdk-qtquickcompiler-sdk" ]; then
        install -m 0644 ${WORKDIR}/libgcc_s_dw2-1.dll ${D}${OE_QMAKE_PATH_BINS}
    fi
}

INHIBIT_PACKAGE_STRIP = "1"
ALLOW_EMPTY_${PN} = "1"
PACKAGES =+ "${PN}-tools"
FILES_${PN}-tools = "${OE_QMAKE_PATH_BINS}"
FILES_${PN}-dev = "${OE_QMAKE_PATH_ARCHDATA}"
INSANE_SKIP_${PN} += "already-stripped"

BBCLASSEXTEND = "native nativesdk"
