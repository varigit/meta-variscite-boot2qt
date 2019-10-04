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

require nativesdk-prebuild-python.inc

COMPATIBLE_HOST = "x86_64.*-mingw.*"

SRC_URI = "\
    https://download.qt.io/development_releases/prebuilt/python/Python35-win-x64.7z \
    https://www.python.org/ftp/python/${PV}/python-${PV}-embed-amd64.zip;name=bin \
    https://download.qt.io/development_releases/prebuilt/python/python-${PV}-modules-amd64.zip;name=modules \
    "

SRC_URI[md5sum] = "08766b13bcbdcf8217a98bfc291d549f"
SRC_URI[sha256sum] = "43e38c8a05dcbc2effd1915dbe2dc2be6e701ebf3eb00d6e45197ee773978124"
SRC_URI[bin.md5sum] = "f1c24bb78bd6dd792a73d5ebfbd3b20e"
SRC_URI[bin.sha256sum] = "faefbd98f61c0d87c5683eeb526ae4d4a9ddc369bef27870cfe1c8939329d066"
SRC_URI[modules.md5sum] = "bf1deaf0a0b807bcd52e11d15892fec2"
SRC_URI[modules.sha256sum] = "cd82789e05bf763b3b67f8e3ec78873c69ce922a13e391298be198702967d6da"
