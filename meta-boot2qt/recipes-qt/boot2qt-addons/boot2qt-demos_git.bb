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

DESCRIPTION = "Boot to Qt Demos"
LICENSE = "BSD | The-Qt-Company-Commercial"
LIC_FILES_CHKSUM = "file://about-b2qt/AboutBoot2Qt.qml;md5=b0a1a6eef4a172b0a8cb4dad9a167d91;beginline=1;endline=49"

inherit qmake5

QT_GIT_PROJECT=""

SRC_URI = " \
    ${QT_GIT}qt-apps/boot2qt-demos.git;branch=${BRANCH};name=demos \
    https://qt-files.s3.amazonaws.com/examples/Videos/Qt+for+Designers+and+Developers.mp4;name=video1 \
    https://qt-files.s3.amazonaws.com/examples/Videos/Qt+for+Device+Creation.mp4;name=video2 \
    https://qt-files.s3.amazonaws.com/examples/Videos/The+Future+is+Written+with+Qt.mp4;name=video3 \
    "

PV = "5.12.1+git${SRCPV}"

BRANCH = "5.12"

SRCREV = "76322dd776d99367c8425f1bd116ad3dec66e52a"

SRC_URI[video1.md5sum] = "25d9e963a02675a4f3ba83abeebb32da"
SRC_URI[video1.sha256sum] = "33125518c2eb7848f378ddb6bebaf39f3327c92f1e33daa7fc09e4260e54d54a"
SRC_URI[video2.md5sum] = "828f4babda370b5d73688ff833e95583"
SRC_URI[video2.sha256sum] = "eba7d3322e63ce47c3433e920f423febfc3533ab05d13ca2f09a4af7d8c6bc44"
SRC_URI[video3.md5sum] = "00966663950a8e7ddcfd6def2a87d57a"
SRC_URI[video3.sha256sum] = "b20ba98464e85cb979f1c505387b0407c4fbec2eaa2170d1360a77ec4c1c2700"

S = "${WORKDIR}/git/basicsuite"

DEPENDS = " \
    qtbase qtdeclarative qtxmlpatterns qtquickcontrols2 qtgraphicaleffects qtmultimedia qtcharts qtlocation \
    ${@bb.utils.contains('DISTRO_FEATURES', 'webengine', 'qtwebengine', '', d)} \
    ${@bb.utils.contains('DISTRO_FEATURES', 'qt5-static', 'qtdeclarative-native', '', d)} \
    "

do_install_append() {
    # we only need plugins from the demos
    rm -rf ${D}/data/user/camera
    rm -rf ${D}/data/user/sensorexplorer
    rm -rf ${D}/data/user/qtwebbrowser

    # we need all qml and content files from the demos we want to use
    cp -r ${S}/datacollector ${D}/data/user/qt/
    cp -r ${S}/ebike-ui ${D}/data/user/qt/
    cp -r ${S}/enterprise-charts ${D}/data/user/qt/
    cp -r ${S}/graphicaleffects ${D}/data/user/qt/
    cp -r ${S}/launchersettings ${D}/data/user/qt/
    cp -r ${S}/mediaplayer ${D}/data/user/qt/
    cp -r ${S}/qtquickcontrols2 ${D}/data/user/qt/
    cp -r ${S}/textinput ${D}/data/user/qt/
    cp -r ${S}/shared ${D}/data/user/qt/
    cp -r ${S}/qtwebbrowser ${D}/data/user/qt/
    cp ${S}/demos.xml ${D}/data/user/qt/

    # but none of the source files
    find ${D}/data/user/qt/ \( -name '*.cpp' -or -name '*.h' -or -name '*.pro' \) -delete
    rm -rf ${D}/data/user/qt/qtwebbrowser/tqtc-qtwebbrowser
    rm -rf ${D}/data/user/qt/qtwebbrowser/qmldir

    install -d -m 0755 ${D}/data/videos
    install -m 0644 ${WORKDIR}/*.mp4 ${D}/data/videos
}

FILES_${PN} += " \
    /data/images/ \
    /data/videos/ \
    /data/user \
    "

FILES_${PN}-dbg += " \
    /data/user/qt/qmlplugins/*/.debug/ \
    "
FILES_${PN}-staticdev += " \
    /data/user/qt/qmlplugins/*/*.a \
    "
