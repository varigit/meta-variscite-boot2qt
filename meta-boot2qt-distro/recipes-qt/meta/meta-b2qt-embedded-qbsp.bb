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
LIC_FILES_CHKSUM = "file://${BOOT2QTBASE}/licenses/The-Qt-Company-Commercial;md5=38de3b110ade3b6ee2f0b6a95ab16f1a"

# get Qt version number
require recipes-qt/qt6/qt6-git.inc
S = "${WORKDIR}"

inherit qbsp

PV := "${@d.getVar('PV').split('+')[0]}"

VERSION_SHORT = "${@d.getVar('PV').replace('.','') if d.getVar('QT_MODULE_BRANCH') != 'dev' else 'dev'}"
QBSP_NAME = "Boot2Qt ${PV}"
QBSP_MACHINE = "${@d.getVar('MACHINE').replace('-','')}"
QBSP_INSTALLER_COMPONENT = "embedded.b2qt.${VERSION_SHORT}.${QBSP_MACHINE}"
QBSP_INSTALL_PATH = "/${PV}/Boot2Qt/${MACHINE}"

QBSP_SDK_TASK = "meta-toolchain-b2qt-embedded-qt6-sdk"
QBSP_IMAGE_TASK = "b2qt-embedded-qt6-image"
