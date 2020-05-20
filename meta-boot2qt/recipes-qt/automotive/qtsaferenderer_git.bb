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

DESCRIPTION = "Qt Safe Renderer"

LICENSE = "GPL-3.0 | The-Qt-Company-Commercial"
LIC_FILES_CHKSUM = "file://${BOOT2QTBASE}/licenses/The-Qt-Company-Commercial;md5=c8b6dd132d52c6e5a545df07a4e3e283"

inherit qt5-module sdk-sources distro_features_check

# the sources are not generally available, support must be explicitly enabled
REQUIRED_DISTRO_FEATURES = "qtsaferenderer"

require recipes-qt/qt5/qt5-git.inc

PACKAGECONFIG ?= ""
PACKAGECONFIG_class-native = "tools-only"
PACKAGECONFIG_class-nativesdk = "tools-only"
PACKAGECONFIG[tools-only] = "CONFIG+=tools-only,,"

EXTRA_QMAKEVARS_PRE += "${PACKAGECONFIG_CONFARGS}"

PV = "1.1.2"
BRANCH = "1.1"
SRC_URI = "\
    git://codereview.qt-project.org/tqtc-boot2qt/qtsaferenderer;branch=${BRANCH};protocol=ssh;sdk-uri=Src/QtSafeRenderer-1.1.2 \
    file://0001-Fix-yocto-build-issues.patch \
    "
SRCREV = "af22b3329df5167c69dffe1e606e28193f1f88b5"

DEPENDS = "qtbase qtdeclarative"

BBCLASSEXTEND = "nativesdk native"
