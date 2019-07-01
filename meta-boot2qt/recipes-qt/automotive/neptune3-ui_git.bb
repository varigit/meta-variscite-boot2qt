############################################################################
##
## Copyright (C) 2019 The Qt Company Ltd.
## Copyright (C) 2019 Pelagicore AG.
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

DESCRIPTION = "Neptune 3 IVI UI"
LICENSE = "Apache-2.0 & ( GPL-3.0 | The-Qt-Company-Commercial )"
LIC_FILES_CHKSUM = "\
    file://LICENSE.GPL3;md5=d32239bcb673463ab874e80d47fae504 \
    file://imports_shared/assets/fonts/LICENSE.txt;md5=3b83ef96387f14655fc854ddc3c6bd57 \
"

inherit qt5-module systemd
require recipes-qt/qt5/qt5-git.inc

QT_GIT_PROJECT = "qt-apps"
QT_MODULE_BRANCH = "5.13"

SRC_URI += " \
    file://neptune.service \
    "
SRC_URI_append_nitrogen6x = " file://0001_hardware_variant_low.patch"
SRC_URI_append_imx6dlsabresd = " file://0001_hardware_variant_low.patch"
SRC_URI_append_imx6qsabresd = " file://0001_hardware_variant_low.patch"
SRC_URI_append_apalis-imx6 = " file://0001_hardware_variant_low.patch"
SRC_URI_append_colibri-imx6 = " file://0001_hardware_variant_low.patch"

SRCREV = "c34ba34891bc686b8573e1346d91be5a15785412"

QMAKE_PROFILES = "${S}/neptune3-ui.pro"

DEPENDS = "\
    qtbase \
    qtdeclarative \
    qttools-native \
    qtquickcontrols2 \
    qtapplicationmanager \
    qtivi qtivi-native \
    qtremoteobjects qtremoteobjects-native \
    "
RDEPENDS_${PN} = "\
    dbus \
    otf-noto otf-noto-arabic ttf-opensans \
    qtapplicationmanager qtapplicationmanager-tools \
    qtvirtualkeyboard \
    qtquickcontrols2-qmlplugins \
    qtgraphicaleffects-qmlplugins \
    qttools-tools qtivi-tools \
    ${@bb.utils.contains('DISTRO_FEATURES', 'webengine', 'qtwebengine', '', d)} \
    "

PACKAGECONFIG ?= "${@bb.utils.filter('DISTRO_FEATURES', 'qtsaferenderer', d)}"
PACKAGECONFIG[qtsaferenderer] = "CONFIG+=use_qsr,,qtsaferenderer qtsaferenderer-native"

EXTRA_QMAKEVARS_PRE += "${PACKAGECONFIG_CONFARGS}"

do_install_append() {
    install -m 0755 -d ${D}${systemd_unitdir}/system
    install -m 0644 ${WORKDIR}/neptune.service ${D}${systemd_unitdir}/system/

    # Move the fonts to the system-wide font location
    install -m 0755 -d ${D}${datadir}/fonts/ttf/
    mv ${D}/opt/neptune3/imports_shared/assets/fonts/*.ttf ${D}${datadir}/fonts/ttf/
    rm -rf ${D}/opt/neptune3/imports_shared/assets/fonts/

    # Don't package tests
    rm -rf ${D}/usr/share/tests
}

PACKAGES =+ "${PN}-apps"
RRECOMMENDS_${PN} += "${PN}-apps"

FILES_${PN}-apps += "/opt/neptune3/apps"
FILES_${PN} += "\
    /opt/neptune3 \
    ${datadir}/fonts/ttf \
    "
FILES_${PN}-dev += "\
    /opt/neptune3/lib/*.so \
    "

SYSTEMD_SERVICE_${PN} = "neptune.service"
