############################################################################
##
## Copyright (C) 2019 The Qt Company Ltd.
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

DEPENDS = "qtbase qtdeclarative qtmultimedia qtivi-native"
DEPENDS_class-native = "qtbase"
DEPENDS_class-nativesdk = "qtbase qtivi-native"

inherit qt5-module
inherit python3native
require recipes-qt/qt5/qt5-git.inc

QT_MODULE_BRANCH_QFACE = "upstream/master"

SRC_URI += " \
    ${QT_GIT}/qtivi-qface.git;name=qface;branch=${QT_MODULE_BRANCH_QFACE};protocol=${QT_GIT_PROTOCOL};destsuffix=git/src/3rdparty/qface \
    file://0001-Use-QT_HOST_BINS-get-for-getting-correct-path.patch \
"

SRCREV_qtivi = "346d123b3e8c7f0e24fd465a00974f4d2189fd08"
SRCREV_qface = "0a3ae7686e1100be452b8c435bdcd84ec242340e"
SRCREV = "${SRCREV_qtivi}"
SRCREV_FORMAT = "qtivi_qface"

PACKAGECONFIG ?= "taglib ivigenerator remoteobjects"
PACKAGECONFIG[taglib] = "QMAKE_EXTRA_ARGS+=-feature-taglib,QMAKE_EXTRA_ARGS+=-no-feature-taglib,taglib"
PACKAGECONFIG[dlt] = "QMAKE_EXTRA_ARGS+=-feature-dlt,QMAKE_EXTRA_ARGS+=-no-feature-dlt,dlt-daemon"
PACKAGECONFIG[geniviextras-only] = "QMAKE_EXTRA_ARGS+=--geniviextras-only"
# For cross-compiling tell qtivi to use the system-ivigenerator, which is installed by the native recipe"
PACKAGECONFIG[ivigenerator] = "QMAKE_EXTRA_ARGS+=-system-ivigenerator"
PACKAGECONFIG[ivigenerator-native] = "QMAKE_EXTRA_ARGS+=-qt-ivigenerator,,python3 python3-virtualenv"
PACKAGECONFIG[host-tools-only] = "QMAKE_EXTRA_ARGS+=-host-tools-only"
PACKAGECONFIG[simulator] = "QMAKE_EXTRA_ARGS+=-feature-simulator,QMAKE_EXTRA_ARGS+=-no-feature-simulator,qtsimulator"
PACKAGECONFIG[simulator-native] = "QMAKE_EXTRA_ARGS+=-feature-simulator QMAKE_EXTRA_ARGS+=--force-ivigenerator-qtsimulator"
PACKAGECONFIG[remoteobjects] = "QMAKE_EXTRA_ARGS+=-feature-remoteobjects,QMAKE_EXTRA_ARGS+=-no-feature-simulator,qtremoteobjects"
PACKAGECONFIG[remoteobjects-native] = "QMAKE_EXTRA_ARGS+=-feature-remoteobjects QMAKE_EXTRA_ARGS+=--force-ivigenerator-qtremoteobjects"

PACKAGECONFIG_class-native ??= "host-tools-only ivigenerator-native remoteobjects-native"
PACKAGECONFIG_class-nativesdk ??= "${PACKAGECONFIG_class-native}"
PACKAGECONFIG_class-nativesdk_mingw32 ??= "host-tools-only"

ALLOW_EMPTY_${PN}-tools = "1"

EXTRA_QMAKEVARS_PRE += "${PACKAGECONFIG_CONFARGS} ${@bb.utils.contains_any('PACKAGECONFIG', 'ivigenerator ivigenerator-native', '', 'QMAKE_EXTRA_ARGS+=-no-ivigenerator', d)}"

set_python_paths() {
    # Otherwise pip might cache or reuse something from our home folder
    export HOME="${STAGING_DATADIR_NATIVE}"
    # This is needed as otherwise the virtualenv tries to use the libs from the host
    export LD_LIBRARY_PATH="${STAGING_LIBDIR_NATIVE}"
    # Let qtivi use the python3-native binaries
    export PYTHON3_PATH="${STAGING_BINDIR_NATIVE}/python3-native"
}
do_compile_prepend() {
    set_python_paths
}
do_install_prepend() {
    set_python_paths
}

# This needs a modified python3 recipe which copies the binary into a path where this recipe can pick it up
# This is needed to provide a proper executable using the correct interpreter in the SDK.
# See https://bugreports.qt.io/browse/AUTOSUITE-176
do_install_append_class-nativesdk() {
    export IVIGENERATOR_ENABLED="${@bb.utils.contains("PACKAGECONFIG", "ivigenerator-native", "1", "0", d)}"

    if [ "${IVIGENERATOR_ENABLED}" = "1" ]; then
        cp ${STAGING_BINDIR}/qt5/python3* ${D}/${OE_QMAKE_PATH_BINS}/ivigenerator/qtivi_qface_virtualenv/bin/
        rm -f ${D}/${OE_QMAKE_PATH_BINS}/ivigenerator/qtivi_qface_virtualenv/bin/python
        ln -sf python3 ${D}/${OE_QMAKE_PATH_BINS}/ivigenerator/qtivi_qface_virtualenv/bin/python
    fi
}


BBCLASSEXTEND += "native nativesdk"

INSANE_SKIP_${PN}_class-native = "already-stripped"
INSANE_SKIP_${PN}_class-nativesdk = "already-stripped"
INSANE_SKIP_${PN}-tools_class-nativesdk = "staticdev file-rdeps libdir build-deps"
