#! /bin/sh
###############################################################################
## Copyright (C) 2016 The Qt Company Ltd.
## Contact: http://www.qt.io/licensing/
##
## This file is part of the Boot to Qt meta layer.
##
## $QT_BEGIN_LICENSE:BSD$
## You may use this file under the terms of the BSD license as follows:
##
## "Redistribution and use in source and binary forms, with or without
## modification, are permitted provided that the following conditions are
## met:
##   * Redistributions of source code must retain the above copyright
##     notice, this list of conditions and the following disclaimer.
##   * Redistributions in binary form must reproduce the above copyright
##     notice, this list of conditions and the following disclaimer in
##     the documentation and/or other materials provided with the
##     distribution.
##   * Neither the name of The Qt Company Ltd nor the names of its
##     contributors may be used to endorse or promote products derived
##     from this software without specific prior written permission.
##
##
## THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
## "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
## LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
## A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
## OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
## SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
## LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
## DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
## THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
## (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
## OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
##
## $QT_END_LICENSE$
###############################################################################
MANUFACTURER="The Qt Company"
PRODUCT_STRING="Boot2Qt Ethernet/RNDIS connection"

DAEMON=/usr/bin/qdbd
CONFIGFS_PATH=/sys/kernel/config

GADGET_CONFIG=$CONFIGFS_PATH/usb_gadget/g1

. /etc/default/qdbd

initialize_gadget() {
    # Initialize gadget with first UDC driver
    for driverpath in /sys/class/udc/*; do
        drivername=`basename $driverpath`
        echo "$drivername" > $GADGET_CONFIG/UDC
        break
    done
}

disable_gadget() {
    echo "" > $GADGET_CONFIG/UDC
}

case "$1" in
start)
    b2qt-gadget-network.sh --reset
    modprobe libcomposite
    sleep 1
    # Gadget configuration
    mkdir -p $GADGET_CONFIG
    echo $VENDOR > $GADGET_CONFIG/idVendor
    echo $PRODUCT > $GADGET_CONFIG/idProduct
    mkdir -p $GADGET_CONFIG/strings/0x409
    echo $MANUFACTURER > $GADGET_CONFIG/strings/0x409/manufacturer
    echo $PRODUCT_STRING > $GADGET_CONFIG/strings/0x409/product
    echo ${SERIAL:0:32} > $GADGET_CONFIG/strings/0x409/serialnumber
    mkdir -p $GADGET_CONFIG/configs/c.1/strings/0x409
    echo "USB Ethernet + QDB" > $GADGET_CONFIG/configs/c.1/strings/0x409/configuration
    mkdir -p $GADGET_CONFIG/functions/rndis.usb0
    mkdir -p $GADGET_CONFIG/functions/ffs.qdb
    ln -sf $GADGET_CONFIG/functions/rndis.usb0 $GADGET_CONFIG/configs/c.1
    ln -sf $GADGET_CONFIG/functions/ffs.qdb $GADGET_CONFIG/configs/c.1
    # Function fs mountpoints
    mkdir -p /dev/usb-ffs
    chmod 770 /dev/usb-ffs
    mkdir -p /dev/usb-ffs/qdb
    chmod 770 /dev/usb-ffs/qdb
    mount -t functionfs qdb /dev/usb-ffs/qdb -o uid=0,gid=0
    shift
    start-stop-daemon --start --quiet --exec $DAEMON -- $@ &
    sleep 1
    initialize_gadget
    ;;
stop)
    disable_gadget
    start-stop-daemon --stop --quiet --exec $DAEMON
    sleep 1
    umount /dev/usb-ffs/qdb
    rm $GADGET_CONFIG/configs/c.1/rndis.usb0
    rm $GADGET_CONFIG/configs/c.1/ffs.qdb
    rmdir $GADGET_CONFIG/configs/c.1/strings/0x409
    rmdir $GADGET_CONFIG/configs/c.1
    rmdir $GADGET_CONFIG/functions/rndis.usb0
    rmdir $GADGET_CONFIG/functions/ffs.qdb
    rmdir $GADGET_CONFIG/strings/0x409
    rmdir $GADGET_CONFIG
    ;;
restart)
    disable_gadget
    start-stop-daemon --stop --quiet --exec $DAEMON
    b2qt-gadget-network.sh --reset
    sleep 1
    shift
    start-stop-daemon --start --quiet --exec $DAEMON -- $@ &
    sleep 1
    initialize_gadget
    ;;
*)
    echo "Usage: $0 {start|stop|restart}"
    exit 1
esac
exit 0
