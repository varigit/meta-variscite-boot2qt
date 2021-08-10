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

FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += "\
    file://TEZI_B2QT_EULA.TXT \
    file://Built_with_Qt.png \
    https://qt-files.s3.amazonaws.com/examples/tezi-marketing-20180905.tar;unpack=false;downloadfilename=marketing.tar \
    "

SRC_URI[md5sum] = "281877560900c6481eee019a923f5e28"
SRC_URI[sha256sum] = "36c31c812e6d6223f46f2a32cad37f46060a7c05420a4ba491cbea6193039eee"

do_deploy:append () {
    install -m 644 ${WORKDIR}/TEZI_B2QT_EULA.TXT ${DEPLOYDIR}
    install -m 644 ${WORKDIR}/Built_with_Qt.png ${DEPLOYDIR}
}
