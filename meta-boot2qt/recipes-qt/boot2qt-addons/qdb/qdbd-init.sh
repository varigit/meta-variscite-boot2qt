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
QDBDAEMON=/usr/bin/qdbd
CONFIG_GADGET_DIR_PATH=/sys/kernel/config/usb_gadget/g1
CONFIG_NAME_AND_NUMBER="c.1"
FUNCTIONFS_PATH=/dev/usb-ffs

. /etc/default/qdbd

function_fs_mountpoint()
{
    mkdir -p $FUNCTIONFS_PATH
    chmod 770 $FUNCTIONFS_PATH
    mkdir -p $FUNCTIONFS_PATH/qdb
    chmod 770 $FUNCTIONFS_PATH/qdb
    mount -t functionfs qdb $FUNCTIONFS_PATH/qdb -o uid=0,gid=0
}

configure_gadget()
{
    CONFIG_GADGET_PRODUCT_STRING=$1
    CONFIG_CONFIGURATION_NAME=$2
    CONFIG_FUNCTION_SYMLINK=$3
    mkdir -p $CONFIG_GADGET_DIR_PATH
    echo $VENDOR > $CONFIG_GADGET_DIR_PATH/idVendor
    echo $PRODUCT > $CONFIG_GADGET_DIR_PATH/idProduct
    mkdir -p $CONFIG_GADGET_DIR_PATH/strings/0x409
    echo $MANUFACTURER > $CONFIG_GADGET_DIR_PATH/strings/0x409/manufacturer
    echo $CONFIG_GADGET_PRODUCT_STRING > $CONFIG_GADGET_DIR_PATH/strings/0x409/product
    echo ${SERIAL:0:32} > $CONFIG_GADGET_DIR_PATH/strings/0x409/serialnumber
    mkdir -p $CONFIG_GADGET_DIR_PATH/configs/$CONFIG_NAME_AND_NUMBER/strings/0x409
    echo $CONFIG_CONFIGURATION_NAME > $CONFIG_GADGET_DIR_PATH/configs/$CONFIG_NAME_AND_NUMBER/strings/0x409/configuration
    mkdir -p $CONFIG_GADGET_DIR_PATH/functions/$CONFIG_FUNCTION_SYMLINK
    mkdir -p $CONFIG_GADGET_DIR_PATH/functions/ffs.qdb
    ln -sf $CONFIG_GADGET_DIR_PATH/functions/$CONFIG_FUNCTION_SYMLINK $CONFIG_GADGET_DIR_PATH/configs/$CONFIG_NAME_AND_NUMBER
    ln -sf $CONFIG_GADGET_DIR_PATH/functions/ffs.qdb $CONFIG_GADGET_DIR_PATH/configs/$CONFIG_NAME_AND_NUMBER
}

unconfigure_gadget()
{
    CONFIG_FUNCTION_SYMLINK=$1
    rm $CONFIG_GADGET_DIR_PATH/configs/$CONFIG_NAME_AND_NUMBER/$CONFIG_FUNCTION_SYMLINK
    rm $CONFIG_GADGET_DIR_PATH/configs/$CONFIG_NAME_AND_NUMBER/ffs.qdb
    rmdir $CONFIG_GADGET_DIR_PATH/configs/$CONFIG_NAME_AND_NUMBER/strings/0x409
    rmdir $CONFIG_GADGET_DIR_PATH/configs/$CONFIG_NAME_AND_NUMBER
    rmdir $CONFIG_GADGET_DIR_PATH/functions/$CONFIG_FUNCTION_SYMLINK
    rmdir $CONFIG_GADGET_DIR_PATH/functions/ffs.qdb
    rmdir $CONFIG_GADGET_DIR_PATH/strings/0x409
    rmdir $CONFIG_GADGET_DIR_PATH
}

if [ $USB_ETHERNET_PROTOCOL = "rndis" ]
then
    FUNCTION_NAME="rndis.usb0"
    PRODUCT_STRING="Boot2Qt-USB-Ethernet-RNDIS"
    CONFIG_NAME="USB-Ethernet_RNDIS+QDB"

elif [ $USB_ETHERNET_PROTOCOL = "cdcecm" ]
then
    FUNCTION_NAME="ecm.usb1"
    PRODUCT_STRING="Boot2Qt-USB-Ethernet-CDC/ECM"
    CONFIG_NAME="USB-Ethernet_CDC-ECM+QDB"
else
    echo "Supported configs in /etc/default/qdbd: 'cdcecm' Mac&Linux, 'rndis' Win10&Linux. Not supported:" $USB_ETHERNET_PROTOCOL
    exit 1
fi

if [ "$1" = "start" ]
then
    echo "start" $USB_ETHERNET_PROTOCOL
    b2qt-gadget-network.sh --reset
    modprobe libcomposite
    sleep 1
    configure_gadget $PRODUCT_STRING $CONFIG_NAME $FUNCTION_NAME
    function_fs_mountpoint
    start-stop-daemon --start --quiet --background --exec $QDBDAEMON -- --usb-ethernet-function-name $FUNCTION_NAME
elif [ "$1" = "stop" ]
then
    echo "stop" $USB_ETHERNET_PROTOCOL
    start-stop-daemon --stop --quiet --exec $QDBDAEMON
    sleep 1
    umount $FUNCTIONFS_PATH/qdb
    unconfigure_gadget $FUNCTION_NAME
elif [ "$1" = "restart" ]
then
    echo "restart" $USB_ETHERNET_PROTOCOL
    start-stop-daemon --stop --quiet --exec $QDBDAEMON
    b2qt-gadget-network.sh --reset
    sleep 1
    start-stop-daemon --start --quiet --background --exec $QDBDAEMON -- --usb-ethernet-function-name $FUNCTION_NAME
else
    echo "Usage: $0 {start|stop|restart}"
    exit 1
fi
exit 0
