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
LIC_FILES_CHKSUM = "file://${BOOT2QTBASE}/licenses/The-Qt-Company-Commercial;md5=38de3b110ade3b6ee2f0b6a95ab16f1a"

inherit populate_sdk

SDKIMAGE_FEATURES = "dev-pkgs"

MACHINE_EXTRA_INSTALL_SDK ?= ""

TOOLCHAIN_HOST_TASK += "nativesdk-packagegroup-b2qt-embedded-toolchain-host"
TOOLCHAIN_TARGET_TASK += "packagegroup-qt6-modules ${MACHINE_EXTRA_INSTALL_SDK}"

PACKAGE_EXCLUDE_COMPLEMENTARY += "\
  ^libqt6 \
  qmlcompilerplus qt3d qt5compat qtapplicationmanager qtbase qtcharts \
  qtcoap qtconnectivity qtdatavis3d qtdeclarative qtdeviceutilities \
  qthttpserver qtimageformats qtinterfaceframework qtlanguageserver qtlottie \
  qtmqtt qtmultimedia qtnetworkauth qtopcua qtpdf qtpositioning \
  qtquick3dphysics qtquick3d qtquickdesigner-components qtquicktimeline \
  qtremoteobjects qtscxml qtsensors qtserialbus qtserialport qtshadertools \
  qtspeech qtsvg qttools qttranslations qtvirtualkeyboard qtvncserver \
  qtwayland qtwebchannel qtwebengine qtwebsockets qtwebview \
"

SDK_POSTPROCESS_COMMAND:prepend = "apply_ci_fixes;"

apply_ci_fixes () {
    # If the request has more than two labels, it is rejected (e.g., apache2.test-net.qt.local)
    sed -i -e '/^hosts:/s/mdns4_minimal/mdns4/' ${SDK_OUTPUT}${SDKTARGETSYSROOT}${sysconfdir}/nsswitch.conf
    # root is expected to be 0755
    chmod g-w ${SDK_OUTPUT}${SDKTARGETSYSROOT}
}
