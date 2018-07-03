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

# Configuration for boot2qt image without (L)GPLv3 components
# Include in your conf/local.conf and add meta-gplv2 layer to your configuration
# https://www.yoctoproject.org/docs/latest/mega-manual/mega-manual.html#migration-2.3-gplv2-and-gplv3-moves

INCOMPATIBLE_LICENSE += "*GPLv3"

IMAGE_FEATURES_remove_pn-b2qt-embedded-qt5-image = "tools-debug debug-tweaks"
IMAGE_FEATURES_remove_pn-b2qt-automotive-qt5-image = "tools-debug debug-tweaks"

RDEPENDS_packagegroup-b2qt-embedded-tools_remove_pn-packagegroup-b2qt-embedded-tools = "binutils binutils-symlinks perf"
RDEPENDS_packagegroup-b2qt-embedded-base_remove_pn-packagegroup-b2qt-embedded-base = "ttf-freefont-mono"

PACKAGECONFIG_remove_pn-qtvirtualkeyboard = "hunspell"
PACKAGECONFIG_remove_pn-python3-pygobject = "cairo"

# intel nuc specific changes
IMAGE_FSTYPES_intel-corei7-64 = "tar.gz"
MACHINE_EXTRA_INSTALL_remove_intel-corei7-64 = "grub-efi-config"
QBSP_IMAGE_CONTENT_intel-corei7-64 = ""
