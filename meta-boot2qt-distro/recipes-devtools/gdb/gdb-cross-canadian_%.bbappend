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

FILESEXTRAPATHS:prepend:sdkmingw32 := "${THISDIR}/${BPN}:"
SRC_URI:append:sdkmingw32 = " file://0001-Do-not-use-win32-specific-filehandling.patch"

DEPENDS:append:sdkmingw32 = " nativesdk-prebuild-python"
RDEPENDS:${PN}:append:sdkmingw32 = " nativesdk-prebuild-python"
EXTRA_OECONF:remove:sdkmingw32 = "--without-python --with-python=no"
EXTRA_OECONF:append:sdkmingw32 = " --with-python=${WORKDIR}/python_win"
CXXFLAGS:append:sdkmingw32 = " -D_hypot=hypot"

do_configure:prepend:sdkmingw32() {
cat > ${WORKDIR}/python_win << EOF
#! /bin/sh
case "\$2" in
        --includes) echo "-I${STAGING_INCDIR}/${PYTHON_DIR}" ;;
        --ldflags) echo "-Wl,-rpath-link,${STAGING_LIBDIR}/.. -lpython35" ;;
        --exec-prefix) echo "${exec_prefix}" ;;
        *) exit 1 ;;
esac
exit 0
EOF
        chmod +x ${WORKDIR}/python_win
}

do_install:append:sdkmingw32() {
    ln -s ../python35.dll ${D}${bindir}/
    ln -s ../python35.zip ${D}${bindir}/
    ln -s ../libgcc_s_seh-1.dll ${D}${bindir}/
    ln -s ../libexpat.dll ${D}${bindir}/
    ln -s ../libiconv-2.dll ${D}${bindir}/
    ln -s ../libintl-8.dll ${D}${bindir}/
    ln -s ../libstdc++-6.dll ${D}${bindir}/
}
