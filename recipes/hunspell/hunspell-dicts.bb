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

DESCRIPTION = "Hunspell Dictionaries"

LICENSE = "GPL-2.0 & (GPL-2.0|LGPL-2.1|MPL-1.1)"
LIC_FILES_CHKSUM = " \
    file://en/license.txt;md5=686e6cb566fd6382c9fcc7a557bf4544 \
    file://ar/COPYING.txt;md5=ccafd10563b9ffba693011bf470062c6 \
"

SRC_URI = "git://github.com/libreoffice/dictionaries.git;branch=libreoffice-5-4-2"

S = "${WORKDIR}/git"

inherit bin_package

# using branch libreoffice-5.4.2 for dictionaries
SRCREV = "28016713cf482d2ac466d03e007ce91ddb8b76aa"

FILES_${PN} = "${datadir}/hunspell"

do_install() {
    install -m 0755 -d ${D}${datadir}/hunspell

    install -m 0755 ${S}/ar/ar.dic ${D}${datadir}/hunspell/ar_EG.dic
    install -m 0755 ${S}/ar/ar.aff ${D}${datadir}/hunspell/ar_EG.aff

    install -m 0755 ${S}/en/en_GB.dic ${D}${datadir}/hunspell
    install -m 0755 ${S}/en/en_GB.aff ${D}${datadir}/hunspell
}
