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

DESCRIPTION = "Boot to Qt Demo - Mediaplayer"
LICENSE = "BSD | The-Qt-Company-Commercial"
LIC_FILES_CHKSUM = "file://${BOOT2QTBASE}/licenses/The-Qt-Company-Commercial;md5=c8b6dd132d52c6e5a545df07a4e3e283"

require boot2qt-demo.inc

S = "${WORKDIR}/git/basicsuite/mediaplayer"

SRC_URI += " \
    https://qt-files.s3.amazonaws.com/examples/Videos/Qt+for+Designers+and+Developers.mp4;name=video1 \
    https://qt-files.s3.amazonaws.com/examples/Videos/Qt+for+Device+Creation.mp4;name=video2 \
    https://qt-files.s3.amazonaws.com/examples/Videos/The+Future+is+Written+with+Qt.mp4;name=video3 \
    "

SRC_URI[video1.md5sum] = "25d9e963a02675a4f3ba83abeebb32da"
SRC_URI[video1.sha256sum] = "33125518c2eb7848f378ddb6bebaf39f3327c92f1e33daa7fc09e4260e54d54a"
SRC_URI[video2.md5sum] = "828f4babda370b5d73688ff833e95583"
SRC_URI[video2.sha256sum] = "eba7d3322e63ce47c3433e920f423febfc3533ab05d13ca2f09a4af7d8c6bc44"
SRC_URI[video3.md5sum] = "00966663950a8e7ddcfd6def2a87d57a"
SRC_URI[video3.sha256sum] = "b20ba98464e85cb979f1c505387b0407c4fbec2eaa2170d1360a77ec4c1c2700"

DEPENDS += "qtbase qtdeclarative qtquickcontrols2"

do_install_append() {
    install -d -m 0755 ${D}/data/videos
    install -m 0644 ${WORKDIR}/*.mp4 ${D}/data/videos
}

FILES_${PN} += "/data/videos/"
