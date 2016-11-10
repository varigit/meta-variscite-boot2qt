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

inherit meta nopackages abi-arch

FILESEXTRAPATHS_prepend := "${B2QTBASE}/files/qbsp:"

SRC_URI = "\
    file://base_package.xml \
    file://image_package.xml \
    file://toolchain_package.xml \
    file://toolchain_installscript.qs \
    "

INHIBIT_DEFAULT_DEPS = "1"
do_qbsp[depends] += "\
    installer-framework:do_populate_sysroot \
    ${QBSP_SDK_TASK}:do_populate_sdk \
    ${QBSP_IMAGE_TASK}:do_image_complete \
    "

QBSP_VERSION ?= "${PV}${VERSION_AUTO_INCREMENT}"
QBSP_INSTALLER_COMPONENT ?= "${MACHINE}"
QBSP_INSTALL_PATH ?= "/Extras/${MACHINE}"

QBSP_LICENSE_DEPENDENCY ?= ""
QBSP_LICENSE_DEPENDENCY_imx = "qt.embedded.b2qt.freescalelicense"

VERSION_AUTO_INCREMENT = "-0-${DATETIME}"
VERSION_AUTO_INCREMENT[vardepsexclude] = "DATETIME"

DEPLOY_CONF_NAME ?= "${MACHINE}"
RELEASEDATE = "${@time.strftime('%Y-%m-%d',time.gmtime())}"

IMAGE_PACKAGE = "${QBSP_IMAGE_TASK}-${MACHINE}.7z"
SDK_NAME = "${DISTRO}-${SDK_MACHINE}-${QBSP_SDK_TASK}-${MACHINE}.${SDK_POSTFIX}"
SDK_POSTFIX = "sh"
SDK_POSTFIX_sdkmingw32 = "7z"
REAL_MULTIMACH_TARGET_SYS = "${TUNE_PKGARCH}${TARGET_VENDOR}-${TARGET_OS}"
SDK_MACHINE = "${@d.getVar('SDKMACHINE', True) or '${SDK_ARCH}'}"

B = "${WORKDIR}/build"

patch_installer_files() {
    sed -e 's#@NAME@#${DEPLOY_CONF_NAME}#' \
        -e 's#@VERSION@#${QBSP_VERSION}#' \
        -e 's#@RELEASEDATE@#${RELEASEDATE}#' \
        -e 's#@MACHINE@#${MACHINE}#' \
        -e 's#@SYSROOT@#${REAL_MULTIMACH_TARGET_SYS}#' \
        -e 's#@TARGET@#${TARGET_SYS}#' \
        -e 's#@ABI@#${ABI}#' \
        -e 's#@INSTALLPATH@#${QBSP_INSTALL_PATH}#' \
        -e 's#@SDKPATH@#${SDKPATH}#' \
        -e 's#@SDKFILE@#${SDK_NAME}#' \
        -e 's#@LICENSEDEPENDENCY@#${QBSP_LICENSE_DEPENDENCY}#' \
        -i ${1}/*
}

prepare_qbsp() {
    # Toolchain component
    TOOLCHAIN_PATH="${B}/pkg/${QBSP_INSTALLER_COMPONENT}.toolchain"
    mkdir -p ${TOOLCHAIN_PATH}/meta
    mkdir -p ${TOOLCHAIN_PATH}/data

    cp ${WORKDIR}/toolchain_package.xml ${TOOLCHAIN_PATH}/meta/package.xml
    cp ${WORKDIR}/toolchain_installscript.qs ${TOOLCHAIN_PATH}/meta/installscript.qs
    patch_installer_files ${TOOLCHAIN_PATH}/meta

    mkdir -p ${B}/toolchain/${QBSP_INSTALL_PATH}/toolchain
    if [ "${SDK_POSTFIX}" == "7z" ]; then
        7z x ${DEPLOY_DIR}/sdk/${SDK_NAME} -o${B}/toolchain/${QBSP_INSTALL_PATH}/toolchain/
    else
        cp ${DEPLOY_DIR}/sdk/${SDK_NAME} ${B}/toolchain/${QBSP_INSTALL_PATH}/toolchain/
    fi

    cd ${B}/toolchain
    archivegen ${TOOLCHAIN_PATH}/data/toolchain.7z *

    # Image component
    IMAGE_PATH="${B}/pkg/${QBSP_INSTALLER_COMPONENT}.system"
    mkdir -p ${IMAGE_PATH}/meta
    mkdir -p ${IMAGE_PATH}/data

    cp ${WORKDIR}/image_package.xml ${IMAGE_PATH}/meta/package.xml
    patch_installer_files ${IMAGE_PATH}/meta

    mkdir -p ${B}/images/${QBSP_INSTALL_PATH}/images
    7z x ${DEPLOY_DIR_IMAGE}/${IMAGE_PACKAGE} -o${B}/images/${QBSP_INSTALL_PATH}/images/

    cd ${B}/images
    archivegen ${IMAGE_PATH}/data/image.7z *

    # Base component
    BASE_PATH="${B}/pkg/${QBSP_INSTALLER_COMPONENT}"
    mkdir -p ${BASE_PATH}/meta

    cp ${WORKDIR}/base_package.xml ${BASE_PATH}/meta/package.xml
    patch_installer_files ${BASE_PATH}/meta
}

create_qbsp() {
    prepare_qbsp

    # Repository creation
    repogen -p ${B}/pkg ${B}/repository

    mkdir -p ${DEPLOY_DIR}/qbsp
    rm -f ${DEPLOY_DIR}/qbsp/${PN}-${MACHINE}.qbsp

    cd ${B}/repository
    archivegen ${DEPLOY_DIR}/qbsp/${PN}-${SDK_MACHINE}-${MACHINE}.qbsp *
}

python do_qbsp() {
    bb.build.exec_func('create_qbsp', d)
}

addtask qbsp after do_unpack before do_build

do_qbsp[cleandirs] += "${B}"

do_configure[noexec] = "1"
do_compile[noexec] = "1"
do_populate_sysroot[noexec] = "1"
do_populate_lic[noexec] = "1"
