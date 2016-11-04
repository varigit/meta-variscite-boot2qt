#!/bin/sh
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

set -e

if [ $# -ne 1 ]; then
    echo "Usage: $0 <image>"
    echo "Mount the two partitions (boot and rootfs) from the image to current folder"
    exit 1
fi

IMAGE=$1

if [ ! -f "${IMAGE}" ]; then
    echo "Image '${IMAGE}' not found"
    exit 1
fi

mkdir -p boot
mkdir -p root

sudo umount boot root || true

OFFSET=$(parted "${IMAGE}" unit B print | grep "^ 1" | awk {'print $2'} | cut -d B -f 1)
sudo mount -o loop,offset=${OFFSET} "${IMAGE}" boot

OFFSET=$(parted "${IMAGE}" unit B print | grep "^ 2" | awk {'print $2'} | cut -d B -f 1)
sudo mount -o loop,offset=${OFFSET} "${IMAGE}" root
