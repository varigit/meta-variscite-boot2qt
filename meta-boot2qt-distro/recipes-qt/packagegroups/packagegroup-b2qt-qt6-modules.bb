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

DESCRIPTION = "Qt6 modules"
LICENSE = "The-Qt-Company-Commercial"

inherit packagegroup

PACKAGEGROUP_DISABLE_COMPLEMENTARY = "1"

RDEPENDS_${PN} += " \
    ${@bb.utils.contains('DISTRO_FEATURES', 'opengl', 'qt3d', '', d)} \
    qtbase \
    qtconnectivity \
    qtdeclarative \
    qtdeclarative-tools \
    ${@bb.utils.contains('DISTRO_FEATURES', 'opengl', 'qtgraphicaleffects', '', d)} \
    qtimageformats \
    qtnetworkauth \
    ${@bb.utils.contains('DISTRO_FEATURES', 'opengl', 'qtquick3d', '', d)} \
    qtquickcontrols2 \
    qtquicktimeline \
    qtremoteobjects \
    qtserialbus \
    qtserialport \
    qtsvg \
    qttools \
    qttools-tools \
    qttranslations-qtbase \
    qttranslations-qtdeclarative \
    qttranslations-qtconnectivity \
    qttranslations-qtserialport \
    qttranslations-qtwebsockets \
    ${@bb.utils.contains('DISTRO_FEATURES', 'wayland', 'qtwayland', '', d)} \
    qtwebsockets \
    qtwebchannel \
    qtvirtualkeyboard \
    "
