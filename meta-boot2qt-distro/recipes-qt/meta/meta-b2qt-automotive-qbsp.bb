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

DESCRIPTION = "Meta task for QBSP creation"

LICENSE = "The-Qt-Company-Commercial"
LIC_FILES_CHKSUM = "file://${QT_LICENSE};md5=948f8877345cd66106f11031977a4625"

# get Qt version number
require recipes-qt/qt5/qt5-git.inc
S = "${WORKDIR}"

inherit qbsp

PV := "${@d.getVar('PV', True).split('+')[0]}"

VERSION_SHORT = "${@d.getVar('PV', True).replace('.','')}"
QBSP_NAME = "Automotive ${PV}"
QBSP_MACHINE = "${@d.getVar('MACHINE', True).replace('-','')}"
QBSP_INSTALLER_COMPONENT = "automotive.${VERSION_SHORT}.yocto.${QBSP_MACHINE}"
QBSP_INSTALL_PATH = "/${PV}/Automotive/${MACHINE}"

QBSP_SDK_TASK = "meta-toolchain-b2qt-automotive-qt5-sdk"
QBSP_IMAGE_TASK = "b2qt-automotive-qt5-image"
