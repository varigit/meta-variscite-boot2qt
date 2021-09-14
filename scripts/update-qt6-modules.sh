#!/bin/bash
############################################################################
##
## Copyright (C) 2021 The Qt Company Ltd.
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
    echo "Usage: $0 <gitdir> [<layerdir>]"
    echo "Update SRCREVs for all Qt modules in the current layer."
    echo "The <gitdir> is path to the super repo, where modules' SHA1 is taken."
    exit 1
fi

SHA1S=$(git -C $1 submodule status --recursive |  cut -c2- | awk '{print $1$2}')
SHA1S=${SHA1S,,}
LAYERDIR=${2:-$PWD}

for S in $SHA1S; do
    SHA1=${S:0:40}
    PROJECT=${S:40}
    BASEPROJECT=$(echo $PROJECT | cut -d / -f 1)
    TAG="${PROJECT}"

    if [ "${PROJECT}" = "qtquick3d/src/3rdparty/assimp/src" ]; then
        TAG="qtquick3d-assimp"
    elif [ "${PROJECT}" = "qt3d/src/3rdparty/assimp/src" ]; then
        TAG="qt3d-assimp"
    elif [ "${PROJECT}" = "qtwebengine/src/3rdparty" ]; then
        TAG="qtwebengine-chromium"
    elif [ "${PROJECT}" = "qtlocation/src/3rdparty/mapbox-gl-native" ]; then
        TAG="qtlocation-mapboxgl"
    elif [ "${PROJECT}" = "qttools/src/assistant/qlitehtml" ]; then
        TAG="qttools-qlitehtml"
    elif [ "${PROJECT}" = "qttools/src/assistant/qlitehtml/src/3rdparty/litehtml" ]; then
        TAG="qttools-qlitehtml-litehtml"
    fi

    if sed -n "/\"${BASEPROJECT}\"/,/status/p" $1/.gitmodules | grep -q ignore ; then
        echo "${PROJECT} -> ignored"
    else
        echo "${PROJECT} -> ${SHA1}"
        sed -E -i -e "/^SRCREV_${TAG} /s/\".*\"/\"${SHA1}\"/" ${LAYERDIR}/recipes-qt/qt6/qt6-git.inc
    fi
done

