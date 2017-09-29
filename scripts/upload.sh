#!/bin/sh
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

set -x
set -e

RELEASE=$(grep PV ../sources/meta-qt5/recipes-qt/qt5/qt5-git.inc | grep -o [0-9.]*)
UPLOADPATH=QT@ci-files02-hki.intra.qt.io:/srv/jenkins_data/enterprise/b2qt/yocto/${RELEASE}/
UPLOADS="\
    tmp/deploy/images/${MACHINE}/b2qt-${PROJECT}-qt5-image-${MACHINE}.7z \
    tmp/deploy/sdk/b2qt-x86_64-meta-toolchain-b2qt-${PROJECT}-qt5-sdk-${MACHINE}.sh \
    tmp/deploy/sdk/b2qt-i686-mingw32-meta-toolchain-b2qt-${PROJECT}-qt5-sdk-${MACHINE}.7z \
    tmp/deploy/sdk/b2qt-x86_64-meta-toolchain-b2qt-embedded-sdk-${MACHINE}.sh \
    "

for f in ${UPLOADS}; do
    if [ -e ${f} ]; then
        rsync -L ${f} ${UPLOADPATH}/
    fi
done
