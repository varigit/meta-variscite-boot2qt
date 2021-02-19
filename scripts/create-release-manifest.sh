#!/bin/sh
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

# Turn manifest from meta-boot2qt into usable release manifest for boot2qt-manifest.
# Use '--use-head' argument to create manifest using HEAD of current branch for
# meta-boot2qt and meta-qt6 instead of current sha1s.
set -e

MANIFEST="scripts/manifest.xml"

if [ ! -f "${MANIFEST}" ]; then
  echo "Manifest file not found: ${MANIFEST}"
  exit 1
fi

if [ "$1" = "--use-head" ]; then
  USE_HEAD=1
fi

BRANCH=$(git branch --show-current)
if [ "$USE_HEAD" ]; then
  REV=${BRANCH}
else
  REV=$(git rev-parse HEAD)
fi

# add meta-boot2qt
sed -i -e '/<project name="meta-qt/i\
\  <project name="meta-boot2qt"\
           remote="qt"\
           revision="'${REV}'"\
           branch="'${BRANCH}'"\
           path="sources/meta-boot2qt">\
    <linkfile dest="setup-environment.sh" src="scripts/setup-environment.sh"/>\
    <linkfile dest="sources/templates" src="meta-boot2qt-distro/conf"/>\
  </project>' ${MANIFEST}

if [ "$USE_HEAD" ]; then
  sed -i -e '/meta-qt6/,/path/s/revision.*/revision="'${BRANCH}'"/' ${MANIFEST}
fi
