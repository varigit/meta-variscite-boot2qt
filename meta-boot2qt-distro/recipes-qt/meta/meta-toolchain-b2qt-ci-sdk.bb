############################################################################
##
## Copyright (C) 2020 The Qt Company Ltd.
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

DESCRIPTION = "Qt6 SDK toolchain for CI use"

LICENSE = "The-Qt-Company-Commercial"
LIC_FILES_CHKSUM = "file://${BOOT2QTBASE}/licenses/The-Qt-Company-Commercial;md5=213dc233cc25f71b1447fbe95ec90adf"

inherit populate_sdk

SDKIMAGE_FEATURES = "dev-pkgs"

TOOLCHAIN_HOST_TASK += "nativesdk-packagegroup-b2qt-embedded-toolchain-host"
TOOLCHAIN_TARGET_TASK += "packagegroup-qt6-modules ${MACHINE_EXTRA_INSTALL_SDK}"

PACKAGE_EXCLUDE += "\
    ${@bb.utils.contains('DISTRO_FEATURES', 'opengl', 'qt3d-dev', '', d)} \
    qt5compat-dev \
    qtbase-dev \
    qtbase-staticdev \
    qtcharts-dev \
    qtcoap-dev \
    qtconnectivity-dev \
    ${@bb.utils.contains('DISTRO_FEATURES', 'opengl', 'qtdatavis3d-dev', '', d)} \
    qtdeclarative-dev \
    qtdeclarative-staticdev \
    qtdeviceutilities-dev \
    qtgraphicaleffects-dev \
    qtimageformats-dev \
    qtlottie-dev \
    qtmqtt-dev \
    qtmultimedia-dev \
    qtnetworkauth-dev \
    qtopcua-dev \
    qtpositioning-dev \
    qtquick3d-dev \
    qtquickdesigner-components-dev \
    qtquicktimeline-dev \
    qtremoteobjects-dev \
    qtscxml-dev \
    qtsensors-dev \
    qtserialbus-dev \
    qtserialport-dev \
    qtshadertools-dev \
    qtspeech-dev \
    qtsvg-dev \
    qttools-dev \
    qttranslations-dev \
    qtvirtualkeyboard-dev \
    ${@bb.utils.contains('DISTRO_FEATURES', 'wayland', 'qtwayland-dev', '', d)} \
    qtwebchannel-dev \
    qtwebsockets-dev \
    "

SDK_POSTPROCESS_COMMAND:prepend = "apply_ci_fixes;"

apply_ci_fixes () {
    # If the request has more than two labels, it is rejected (e.g., apache2.test-net.qt.local)
    sed -i -e '/^hosts:/s/mdns4_minimal/mdns4/' ${SDK_OUTPUT}${SDKTARGETSYSROOT}${sysconfdir}/nsswitch.conf
    # root is expected to be 0755
    chmod g-w ${SDK_OUTPUT}${SDKTARGETSYSROOT}
}
