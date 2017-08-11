############################################################################
##
## Copyright (C) 2016 The Qt Company Ltd.
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

DESCRIPTION = "Qt Installer Framework"
LICENSE = "The-Qt-Company-DCLA-2.1"
LIC_FILES_CHKSUM = "file://${QT_LICENSE};md5=80e06902b5f0e94ad0a78ee4f7fcb74b"

inherit bin_package native

SRC_URI = "http://ci-files02-hki.intra.qt.io/packages/jenkins/opensource/ifw/installer-framework/installer-framework-build-stripped-linux-x64.7z"

SRC_URI[md5sum] = "08beb5450c3938fcfd1b380f6aaec75d"
SRC_URI[sha256sum] = "91bfef896db58f28e4c2c6db437b958101a59e87aa880c38b6ddc40ebe6c38e6"

S = "${WORKDIR}/ifw-pkg"

do_install() {
    install -d ${D}${bindir}
    install -m 0755 -t ${D}${bindir} ${S}/bin/*
}

INSANE_SKIP_${PN} += "already-stripped"
