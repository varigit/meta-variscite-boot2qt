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

DESCRIPTION = "Qt Quick Compiler"
LICENSE = "The-Qt-Company-DCLA-2.1"
LIC_FILES_CHKSUM = "file://compiler/qtquickcompiler.h;md5=02f6307ab0d6c4bd38a1540f16ea705d;beginline=1;endline=17"

inherit qt5-module

SRC_URI = " \
    git://codereview.qt-project.org/qt/tqtc-qmlcompiler;nobranch=1;protocol=ssh \
    "

SRCREV = "cd3e5533e0597aece6d1e536e2b57beff15e1c5f"

S = "${WORKDIR}/git"

DEPENDS = "qtbase qtdeclarative"

do_install_append() {
    # Use the EffectivePath instead of installation path
    sed -i -e 's|QT_HOST_BINS|QT_HOST_BINS/get|' ${D}${OE_QMAKE_PATH_ARCHDATA}/mkspecs/features/qtquickcompiler.prf
}

BBCLASSEXTEND = "native nativesdk"
