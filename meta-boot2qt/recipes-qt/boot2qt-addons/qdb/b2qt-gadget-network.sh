#!/bin/sh
############################################################################
##
## Copyright (C) 2017 The Qt Company Ltd.
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

NETWORK_UNIT=/usr/lib/systemd/network/usb-rndis.network

usage() {
    echo "Usage: $(basename $0) --reset"
    echo "       $(basename $0) --set <network>"
    echo
    echo "Network is given as the device IPv4 address followed by the prefix length."
    echo "For example \"192.168.0.1/24\"."
    exit 1
}

while test -n "$1"; do
    case "$1" in
        "help" | "--help" | "-h")
            usage
            exit 0
            ;;
        "--reset")
            if [ -n "$COMMAND" ]; then
               usage
               exit 1
            fi
            COMMAND="reset"
            ;;
        "--set")
            if [ -n "$COMMAND" ]; then
                usage
                exit 1
            fi
            COMMAND="set"
            shift
            NETWORK=$1
            ;;
    esac
    shift
done

if [ -z "$COMMAND" ]; then
    usage
    exit 1
fi

case "$COMMAND" in
    "set")
        cat <<EOF > $NETWORK_UNIT
# This file is automatically written by b2qt-gadget-network.sh
[Match]
Type=gadget

[Network]
Address=${NETWORK}
DHCPServer=yes

[DHCPServer]
EmitDNS=no
EmitRouter=no
EOF
        ;;
    "reset")
        cat <<EOF > $NETWORK_UNIT
# This file is automatically written by b2qt-gadget-network.sh
[Match]
Type=gadget

[Network]
DHCPServer=no
EOF
        ;;
esac

systemctl restart systemd-networkd
