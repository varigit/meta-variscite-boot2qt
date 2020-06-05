############################################################################
##
## Copyright (C) 2019 The Qt Company Ltd.
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

DESCRIPTION = "Qt IVI"
LICENSE = "(GFDL-1.3 & BSD & The-Qt-Company-GPL-Exception-1.0 & (LGPL-3.0 | GPL-2.0+)) | The-Qt-Company-Commercial"
LIC_FILES_CHKSUM = "file://LICENSE.FDL;md5=6d9f2a9af4c8b8c3c769f6cc1b6aaf7e \
                    file://LICENSE.GPL2;md5=b234ee4d69f5fce4486a80fdaf4a4263 \
                    file://LICENSE.GPL3;md5=d32239bcb673463ab874e80d47fae504 \
                    file://LICENSE.GPL3-EXCEPT;md5=763d8c535a234d9a3fb682c7ecb6c073 \
                    file://LICENSE.LGPL3;md5=e6a600fd5e1d9cbde2d983680233ad02"

DEPENDS = "qtbase qtdeclarative qtmultimedia qtivi-native qtquickcontrols2"
DEPENDS_class-native = "qtbase"
DEPENDS_class-nativesdk = "qtbase qtivi-native"
RDEPENDS_${PN}-tools += " ${@bb.utils.contains('PACKAGECONFIG','ivigenerator-native','qface','', d)}"
RDEPENDS_${PN}-dev += " ${PN}-staticdev"

inherit qt5-module
inherit python3native
inherit systemd
require recipes-qt/qt5/qt5-git.inc

SRC_URI += " \
    file://0001-Use-QT_HOST_BINS-get-for-getting-correct-path.patch \
    file://ivimedia-simulation-server.service \
    file://ivivehiclefunctions-simulation-server.service \
    file://ivi-services.target \
"

SRCREV = "26dc6d41c48b15515a9439c91969c167e5599b3f"

PACKAGECONFIG ?= "taglib ivigenerator remoteobjects"
PACKAGECONFIG[taglib] = "QMAKE_EXTRA_ARGS+=-feature-taglib,QMAKE_EXTRA_ARGS+=-no-feature-taglib,taglib"
PACKAGECONFIG[dlt] = "QMAKE_EXTRA_ARGS+=-feature-dlt,QMAKE_EXTRA_ARGS+=-no-feature-dlt,dlt-daemon"
PACKAGECONFIG[geniviextras-only] = "QMAKE_EXTRA_ARGS+=--geniviextras-only"
# For cross-compiling tell qtivi to use the system-ivigenerator, which is installed by the native recipe"
PACKAGECONFIG[ivigenerator] = "QMAKE_EXTRA_ARGS+=-system-qface QMAKE_EXTRA_ARGS+=-system-ivigenerator"
PACKAGECONFIG[ivigenerator-native] = "QMAKE_EXTRA_ARGS+=-system-qface QMAKE_EXTRA_ARGS+=-qt-ivigenerator,,qface"
PACKAGECONFIG[host-tools-only] = "QMAKE_EXTRA_ARGS+=-host-tools-only"
PACKAGECONFIG[remoteobjects] = "QMAKE_EXTRA_ARGS+=-feature-remoteobjects,,qtremoteobjects qtremoteobjects-native"
PACKAGECONFIG[remoteobjects-native] = "QMAKE_EXTRA_ARGS+=-feature-remoteobjects QMAKE_EXTRA_ARGS+=--force-ivigenerator-qtremoteobjects"

PACKAGECONFIG_class-native ??= "host-tools-only ivigenerator-native remoteobjects-native"
PACKAGECONFIG_class-nativesdk ??= "${PACKAGECONFIG_class-native}"

ALLOW_EMPTY_${PN}-tools = "1"

EXTRA_QMAKEVARS_PRE += "${PACKAGECONFIG_CONFARGS} ${@bb.utils.contains_any('PACKAGECONFIG', 'ivigenerator ivigenerator-native', '', 'QMAKE_EXTRA_ARGS+=-no-ivigenerator', d)}"

do_install_append_class-target() {
    install -m 0755 -d ${D}${systemd_unitdir}/system
    install -m 0644 ${WORKDIR}/ivimedia-simulation-server.service ${D}${systemd_unitdir}/system/
    install -m 0644 ${WORKDIR}/ivivehiclefunctions-simulation-server.service ${D}${systemd_unitdir}/system/
    install -m 0644 ${WORKDIR}/ivi-services.target ${D}${systemd_unitdir}/system/
}

SYSTEMD_PACKAGES = "${PN}-tools"
SYSTEMD_SERVICE_${PN}-tools = " \
    ivimedia-simulation-server.service \
    ivivehiclefunctions-simulation-server.service \
    ivi-services.target \
    "

FILES_${PN}-tools += "${systemd_unitdir}/system"

BBCLASSEXTEND += "native nativesdk"

