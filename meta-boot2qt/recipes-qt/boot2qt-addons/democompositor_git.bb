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

DESCRIPTION = "Boot to Qt Wayland Demo Compositor"
LICENSE = "BSD | The-Qt-Company-Commercial"
LIC_FILES_CHKSUM = "file://main.cpp;md5=b0a1a6eef4a172b0a8cb4dad9a167d91;beginline=1;endline=49"

inherit qmake5
require recipes-qt/qt5/qt5-git.inc

QT_GIT = "git://codereview.qt-project.org/${QT_GIT_PROJECT}"
QT_GIT_PROTOCOL = "http"
QT_GIT_PROJECT = "qt-apps"
QT_MODULE = "boot2qt-demos"

SRCREV = "9d6a97f0fb5ff22a12f5c1dc0761fcbfb3490c0a"

S = "${WORKDIR}/git/wayland/democompositor/"

DEPENDS = "qtbase qtwayland"

FILES_${PN} += "/data/user/democompositor"
FILES_${PN}-dbg += "/data/user/democompositor/.debug"
