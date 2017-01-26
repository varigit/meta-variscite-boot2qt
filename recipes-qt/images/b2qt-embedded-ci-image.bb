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

DESCRIPTION = "B2Qt on embedded Linux SDK image"
LICENSE = "The-Qt-Company-DCLA-2.1"
PR = "r0"

IMAGE_FEATURES += "\
        package-management \
        ssh-server-dropbear \
        tools-debug \
        debug-tweaks \
        hwcodecs \
        "

inherit core-image

IMAGE_INSTALL += "\
    packagegroup-b2qt-embedded-base \
    packagegroup-b2qt-embedded-tools \
    ${@bb.utils.contains("DISTRO_FEATURES", "gstreamer010", "packagegroup-b2qt-embedded-gstreamer010", "", d)} \
    ${@bb.utils.contains("DISTRO_FEATURES", "gstreamer", "packagegroup-b2qt-embedded-gstreamer", "", d)} \
    packagegroup-b2qt-qt5-modules \
    "

ROOTFS_POSTINSTALL_COMMAND += "remove_qt_from_rootfs;"

python remove_qt_from_rootfs() {
    import subprocess

    # remove qtbase and all dependent packages
    image_rootfs = d.getVar('IMAGE_ROOTFS', True)
    opkg_conf = d.getVar("IPKGCONF_TARGET", True)
    opkg_cmd = bb.utils.which(os.getenv('PATH'), "opkg")
    opkg_args = "--volatile-cache -f %s -o %s " % (opkg_conf, image_rootfs)
    opkg_args += d.getVar("OPKG_ARGS", True)

    cmd = "%s %s --force-remove --force-removal-of-dependent-packages remove %s" % \
        (opkg_cmd, opkg_args, 'qtbase')

    try:
        bb.note(cmd)
        output = subprocess.check_output(cmd.split(), stderr=subprocess.STDOUT)
        bb.note(output)
    except subprocess.CalledProcessError as e:
        bb.fatal("Unable to remove packages. Command '%s' "
                 "returned %d:\n%s" % (e.cmd, e.returncode, e.output))
}
