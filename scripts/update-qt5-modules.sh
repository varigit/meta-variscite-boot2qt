#!/bin/bash
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

if [ $# -lt 1 ]; then
    echo "Usage: $0 <qt5.git> [<layerdir>]"
    echo "Update SRCREVs for all Qt modules in the current layer."
    echo "The <qt5.git> is path to the qt5 super repo, where modules' SHA1 is taken."
    exit 1
fi

SHA1S=$(git -C $1 submodule status --recursive |  cut -c2- | awk '{print $1$2}')
SHA1S=${SHA1S,,}
LAYERDIR=${2:-$PWD}

for S in $SHA1S; do
    SHA1=${S:0:40}
    PROJECT=${S:40}

    if [ "${PROJECT}" = "qtquick3d" ]; then
        RECIPE="qtquick3d"
        TAG="SRCREV_qtquick3d"
    elif [ "${PROJECT}" = "qtquick3d/src/3rdparty/assimp/src" ]; then
        RECIPE="qtquick3d"
        TAG="SRCREV_assimp"
    elif [ "${PROJECT}" = "qtwebengine" ]; then
        RECIPE="qtwebengine"
        TAG="SRCREV_qtwebengine"
    elif [ "${PROJECT}" = "qtwebengine/src/3rdparty" ]; then
        RECIPE="qtwebengine"
        TAG="SRCREV_chromium"
    elif [ "${PROJECT}" = "qtlocation" ]; then
        RECIPE="qtlocation"
        TAG="SRCREV_qtlocation"
    elif [ "${PROJECT}" = "qtlocation/src/3rdparty/mapbox-gl-native" ]; then
        RECIPE="qtlocation"
        TAG="SRCREV_qtlocation-mapboxgl"
    else
        RECIPE="${PROJECT}"
        TAG="SRCREV"
    fi

    RECIPES=$(find ${LAYERDIR} -regextype egrep -regex ".*/(nativesdk-)?${RECIPE}(-native)?_git.bb(append)?")

    if [ "${RECIPES}" != "" ]; then
        sed -i -e "/^${TAG}/s/\".*\"/\"${SHA1}\"/" ${RECIPES}
        echo "${PROJECT} -> ${SHA1}"
    else
        echo "${PROJECT} -> no recipe found"
    fi
done

