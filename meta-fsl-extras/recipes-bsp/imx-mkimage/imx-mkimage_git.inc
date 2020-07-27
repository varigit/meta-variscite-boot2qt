# Copyright 2017-2019 NXP

IMX_MKIMAGE_SRC ?= "git://source.codeaurora.org/external/imx/imx-mkimage.git;protocol=https"
SRCBRANCH = "imx_4.14.98_2.3.0"
SRC_URI = "${IMX_MKIMAGE_SRC};branch=${SRCBRANCH}"
SRCREV = "d7f9440dd5c050cc22cb362d53d4048e689a0c01" 

DEPENDS = "zlib-native openssl-native"
