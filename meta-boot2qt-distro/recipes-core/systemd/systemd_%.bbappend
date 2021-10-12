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

FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
SRC_URI += " \
    file://usb-rndis.network \
"

PACKAGECONFIG:append = " networkd"

# By default sytemd uses it's build time as epoch. This causes problems when
# using yocto cache since systemd build time might be more than day older than
# the actual image build time. If that kind of image is booted with a device
# that does not have backup battery for RTC, the first fsck interprets successful
# result as failure because last mount time is in the future. This can be worked
# around by setting TIME_EPOCH to 0, which causes fsck to detect the system time as
# insane and ignore the mount time error.
EXTRA_OECONF:append = " --with-time-epoch=0"

do_install:append() {
    # remove login from tty1
    rm -f ${D}${sysconfdir}/systemd/system/getty.target.wants/getty@tty1.service
    # set up link-local IPs for USB network interface
    install -d ${D}${prefix}/lib/systemd/network/
    install -m 0644 ${WORKDIR}/usb-rndis.network ${D}${prefix}/lib/systemd/network/
}
