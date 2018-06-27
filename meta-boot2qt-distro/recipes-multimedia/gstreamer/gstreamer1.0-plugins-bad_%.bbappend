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

PACKAGECONFIG_append = " faad"

inherit qmake5_paths

PACKAGECONFIG[qt5] = '--enable-qt \
                      --with-moc="${OE_QMAKE_PATH_EXTERNAL_HOST_BINS}/moc" \
                      --with-uic="${OE_QMAKE_PATH_EXTERNAL_HOST_BINS}/uic" \
                      --with-rcc="${OE_QMAKE_PATH_EXTERNAL_HOST_BINS}/rcc" \
                     ,--disable-qt,qtbase qtdeclarative qtbase-native'

# The GStreamer Qt5 plugin needs desktop OpenGL or OpenGL ES to work, so make sure it is enabled
python() {
    cur_packageconfig = d.getVar('PACKAGECONFIG',True).split()
    if 'qt5' in cur_packageconfig and not (('opengl' in cur_packageconfig) or ('gles2' in cur_packageconfig)):
        gl_packageconfig = d.getVar('PACKAGECONFIG_GL',True)
        d.appendVar('PACKAGECONFIG', ' ' + gl_packageconfig)
}
