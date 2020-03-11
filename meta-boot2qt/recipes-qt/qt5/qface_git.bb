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

inherit pypi setuptools3

DEPS += " python3-jinja2 \
          python3-click \
          python3-pyyaml \
          python3-pytest \
          python3-six \
          python3-path.py \
          antlr4-python3-runtime \
          python3-watchdog \
          python3-markupsafe \
          python3-setuptools \
        "
DEPENDS += "${DEPS}"
RDEPENDS_${PN} += "${DEPS}"

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://LICENSE;md5=eee61e10a40b0e3045ee5965bcd9a8b5"
SRC_URI = "git://code.qt.io/qt/qtivi-qface.git;protocol=https;nobranch=1"
SRCREV = "fbf55d919222a5c90f037842958f055ed3bd1eb3"
PV = "2.0.3"
S = "${WORKDIR}/git"
CLEANBROKEN = "1"

BBCLASSEXTEND = "nativesdk native"
