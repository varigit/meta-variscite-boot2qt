#!/bin/sh
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

while test -n "$1"; do
  case "$1" in
    "--help" | "-h")
      echo "Usage: . $0 [build directory]"
      return 0
      ;;
    *)
      BUILDDIRECTORY=$1
      ;;
  esac
  shift
done

THIS_SCRIPT="setup-environment.sh"
if [ "$(basename -- $0)" = "${THIS_SCRIPT}" ]; then
  echo "Error: This script needs to be sourced. Please run as '. $0'"
  return 1
fi

if [ -z "$MACHINE" ]; then
  echo "Error: MACHINE environment variable not defined"
  return 1
fi

BUILDDIRECTORY=${BUILDDIRECTORY:-build-${MACHINE}}

if [ ! -e ${PWD}/${BUILDDIRECTORY} ]; then
  case ${MACHINE} in
    apalis-*|colibri-*)
      LAYERSCONF="bblayers.conf.toradex.sample"
      ;;
    nitrogen*)
      LAYERSCONF="bblayers.conf.boundary.sample"
      ;;
    imx*)
      LAYERSCONF="bblayers.conf.fsl.sample"
      ;;
    raspberrypi*)
      LAYERSCONF="bblayers.conf.rpi.sample"
      ;;
    intel-corei7-64)
      LAYERSCONF="bblayers.conf.intel.sample"
      ;;
    jetson-*)
      LAYERSCONF="bblayers.conf.jetson.sample"
      ;;
    *)
      LAYERSCONF="bblayers.conf.sample"
      ;;
  esac
  LAYERSCONF=${PWD}/sources/templates/${LAYERSCONF}
  if [ ! -e ${LAYERSCONF} ]; then
    echo "Error: Could not find layer conf '${LAYERSCONF}'"
    return 1
  fi

  mkdir -p ${PWD}/${BUILDDIRECTORY}/conf
  cp ${LAYERSCONF} ${PWD}/${BUILDDIRECTORY}/conf/bblayers.conf
  if [ ! -e "${PWD}/sources/templates/local.conf.sample" ]; then
    cp ${PWD}/sources/meta-boot2qt/meta-boot2qt-distro/conf/local.conf.sample  ${PWD}/${BUILDDIRECTORY}/conf/local.conf
  fi

  if [ -e ${PWD}/sources/meta-boot2qt/.QT-FOR-DEVICE-CREATION-LICENSE-AGREEMENT ]; then
    QT_SDK_PATH=$(readlink -f ${PWD}/sources/meta-boot2qt/../../../../)
  fi
fi

export TEMPLATECONF="${PWD}/sources/templates"
. sources/poky/oe-init-build-env ${BUILDDIRECTORY}

# use sources from Qt SDK if that is available
sed -i -e "/QT_SDK_PATH/s:\"\":\"${QT_SDK_PATH}\":" conf/local.conf

unset BUILDDIRECTORY
unset QT_SDK_PATH
unset TEMPLATECONF
unset LAYERSCONF
