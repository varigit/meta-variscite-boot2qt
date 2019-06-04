############################################################################
##
## Copyright (C) 2019 Luxoft
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

PYPI_PACKAGE = "antlr4-python3-runtime"
inherit pypi setuptools3

LICENSE = "BSD"
LIC_FILES_CHKSUM = "file://PKG-INFO;md5=82cf535e84b8bb409a9f58ee1475511a"
SRC_URI[md5sum] = "9535eeef56e96699106c04c8937c2ef6"
SRC_URI[sha256sum] = "1b26b72c4492cef310542da10bf6b2ab4aa1775618fc6003f75b55ae9eaa3fd3"

BBCLASSEXTEND = "nativesdk native"
