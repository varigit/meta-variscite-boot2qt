############################################################################
##
## Copyright (C) 2018 The Qt Company Ltd.
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

FILESEXTRAPATHS_prepend_draak := "${THISDIR}/${PN}:"

DEPENDS += "bison-native"

BRANCH = "v2018.09/rcar-3.9.1"
SRCREV = "4d322dccdcf49c0aab18eb703663128aec81cffc"
LIC_FILES_CHKSUM = "file://Licenses/README;md5=30503fd321432fc713238f582193b78e"

LICENSE_draak = "GPLv2+"

S_draak = "${WORKDIR}/git"

do_deploy_prepend_draak() {
    cp ${B}/${UBOOT_SREC} ${S}/${UBOOT_SREC}
}
