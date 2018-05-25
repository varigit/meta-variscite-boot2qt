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
LICENSE = "BSD | The-Qt-Company-DCLA-2.1"
LIC_FILES_CHKSUM = "file://about-b2qt/AboutBoot2Qt.qml;md5=b0a1a6eef4a172b0a8cb4dad9a167d91;beginline=1;endline=49"

inherit qmake5

QT_GIT_PROJECT=""

SRC_URI = " \
    ${QT_GIT}qt-apps/boot2qt-demos.git;branch=${BRANCH};name=demos \
    ${QT_GIT}qt-apps/qtwebbrowser.git;branch=${BROWSER_BRANCH};name=qtwebbrowser;destsuffix=git/basicsuite/qtwebbrowser/tqtc-qtwebbrowser \
    https://s3-eu-west-1.amazonaws.com/qt-files/examples/Videos/Qt_video_720p.webm;name=video1 \
    https://s3-eu-west-1.amazonaws.com/qt-files/examples/Videos/Qt+World+Summit+2015+Recap.mp4;name=video2 \
    "

PV = "5.11.1+git${SRCPV}"

BRANCH = "5.11"
BROWSER_BRANCH = "dev"

SRCREV_demos = "054a2eabcae4a3eb6f7036b0706a96ed0c1f9a00"
SRCREV_qtwebbrowser = "09d629199fa153ea7954321d81f647d5eb52fb6c"
SRCREV_FORMAT = "demos_qtwebbrowser"

SRC_URI[video1.md5sum] = "56de4dcfd5201952dce9af9c69fcec9b"
SRC_URI[video1.sha256sum] = "809123419acac99353439e52c870e2e497dfa8f434ef0777e6c7303e6ad27f89"
SRC_URI[video2.md5sum] = "e03422de1dba27189872e7d579e7da1b"
SRC_URI[video2.sha256sum] = "651e0b4d2b3272dc10bfc9edba4f0c1a7084cd087c75e8a098f7ba3454c7e485"

S = "${WORKDIR}/git/basicsuite"

DEPENDS = "qtbase qtdeclarative qtxmlpatterns qtquickcontrols2 qtgraphicaleffects qtmultimedia qtcharts qtlocation \
           ${@bb.utils.contains('DISTRO_FEATURES', 'webengine', 'qtwebengine', '', d)}"

do_install_append() {
    # we only need plugins from the demos
    rm -rf ${D}/data/user/camera
    rm -rf ${D}/data/user/sensorexplorer
    rm -rf ${D}/data/user/qtwebbrowser

    # we need all qml and content files
    cp -r ${S}/* ${D}/data/user/qt/

    # but none of the source files
    find ${D}/data/user/qt/ \( -name '*.cpp' -or -name '*.h' -or -name '*.pro' \) -delete
    rm -rf ${D}/data/user/qt/qtwebbrowser/tqtc-qtwebbrowser
    rm -rf ${D}/data/user/qt/qtwebbrowser/qmldir

    if [ -d ${WORKDIR}/git/images ]; then
        install -d 0755 ${D}/data/images
        install -m 0644 ${WORKDIR}/git/images/* ${D}/data/images/
    fi

    install -d -m 0755 ${D}/data/videos
    install -m 0644 ${WORKDIR}/Qt_video_720p.webm ${D}/data/videos
    install -m 0644 ${WORKDIR}/Qt+World+Summit+2015+Recap.mp4 ${D}/data/videos

    # Common settings
    cp ${D}/data/user/qt/shared/settings.js ${D}/data/user/qt/enterprise-charts/
    cp ${D}/data/user/qt/shared/settings.js ${D}/data/user/qt/graphicaleffects/
    cp ${D}/data/user/qt/shared/settings.js ${D}/data/user/qt/mediaplayer/

    # Image paths
    sed -i 's#arrow.png#images/arrow.png#' ${D}/data/user/qt/qtquickcontrols2/*.qml
    sed -i 's#qt-logo.png#images/qt-logo.png#' ${D}/data/user/qt/qtquickcontrols2/*.qml
    sed -i 's#back.png#icons/gallery/20x20/back.png#' ${D}/data/user/qt/qtquickcontrols2/*.qml
    sed -i 's#drawer.png#icons/gallery/20x20/drawer.png#' ${D}/data/user/qt/qtquickcontrols2/*.qml
    sed -i 's#menu.png#icons/gallery/20x20/menu.png#' ${D}/data/user/qt/qtquickcontrols2/*.qml

    # Page references (source: "SomePage.qml" -> source: "pages/SomePage.qml")
    sed -i 's#source: \"\(.*\)Page.qml#source: \"pages/\1Page.qml#' ${D}/data/user/qt/qtquickcontrols2/main.qml
}

FILES_${PN} += " \
    /data/images/ \
    /data/videos/ \
    /data/user \
    "

FILES_${PN}-dbg += " \
    /data/user/qt/qmlplugins/*/.debug/ \
    "
