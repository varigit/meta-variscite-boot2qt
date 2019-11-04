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

# Define the osmesa block in PACKAGECONFIG for target, this block is
# not defined in the master recipe, effectively causing the osmesa
# feature to be disabled and -Dosmesa=none set.
PACKAGECONFIG_append_mx6 = " osmesa"

# Solve 'Problem encountered: OSMesa classic requires dri (classic) swrast.'
# by defining the dri swrast for mx8mm machine
DRIDRIVERS_append_mx6 = "swrast"

# Solve 'ERROR: Problem encountered: Only one swrast provider can be built'
# by excluding gallium support, dri is used together with 'classic' mesa backend.
PACKAGECONFIG_remove_mx6 = "gallium"
