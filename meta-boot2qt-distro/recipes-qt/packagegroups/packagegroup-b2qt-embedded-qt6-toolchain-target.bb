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

DESCRIPTION = "Target packages for B2Qt embedded Qt5 SDK"
LICENSE = "The-Qt-Company-Commercial"
PR = "r0"

inherit packagegroup

PACKAGEGROUP_DISABLE_COMPLEMENTARY = "1"

MACHINE_EXTRA_INSTALL_SDK ?= ""

GCC-SANITIZERS ?= "gcc-sanitizers"
GCC-SANITIZERS_mipsarch = ""
GCC-SANITIZERS_libc-musl = ""

RDEPENDS_${PN} += " \
    ${MACHINE_EXTRA_INSTALL_SDK} \
    packagegroup-core-standalone-sdk-target \
    ${GCC-SANITIZERS} \
    \
    ${@bb.utils.contains('DISTRO_FEATURES', 'opengl', 'qt3d-dev', '', d)} \
    qtbase-dev \
    qtbase-staticdev \
    qtconnectivity-dev \
    qtdeclarative-dev \
    qtdeclarative-staticdev \
    ${@bb.utils.contains('DISTRO_FEATURES', 'opengl', 'qtgraphicaleffects-dev', '', d)} \
    qtimageformats-dev \
    qtnetworkauth-dev \
    ${@bb.utils.contains('DISTRO_FEATURES', 'opengl', 'qtquick3d-dev', '', d)} \
    qtquickcontrols2-dev \
    qtquicktimeline-dev \
    qtremoteobjects-dev \
    qtserialbus-dev \
    qtserialport-dev \
    qtsvg-dev \
    qttools-dev \
    qtvirtualkeyboard-dev \
    ${@bb.utils.contains('DISTRO_FEATURES', 'wayland', 'qtwayland-dev', '', d)} \
    qtwebsockets-dev \
    qtwebchannel-dev \
    "
