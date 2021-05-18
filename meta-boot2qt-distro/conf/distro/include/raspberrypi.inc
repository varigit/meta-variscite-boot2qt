############################################################################
##
## Copyright (C) 2021 The Qt Company Ltd.
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

DEPLOY_CONF_NAME_raspberrypi = "Raspberry Pi"
DEPLOY_CONF_NAME_raspberrypi0 = "Raspberry Pi Zero"
DEPLOY_CONF_NAME_raspberrypi2 = "Raspberry Pi 2"
DEPLOY_CONF_NAME_raspberrypi3 = "Raspberry Pi 3"
DEPLOY_CONF_NAME_raspberrypi4 = "Raspberry Pi 4"
DEPLOY_CONF_NAME_raspberrypi4-64 = "Raspberry Pi 4 64-bit"

IMAGE_FSTYPES += "wic.xz"

DEPLOY_CONF_IMAGE_TYPE = "wic.xz"

QBSP_IMAGE_CONTENT += "\
    ${IMAGE_LINK_NAME}.${DEPLOY_CONF_IMAGE_TYPE} \
    ${IMAGE_LINK_NAME}.conf \
    ${IMAGE_LINK_NAME}.info \
    "

MACHINE_EXTRA_INSTALL_append_arm = "\
        omxplayer \
        "

# ogl-runtime depends on gles3
OGL_RUNTIME = ""
OGL_RUNTIME_DEV = ""

KERNEL_MODULE_AUTOLOAD += "snd-bcm2835 bcm2835-v4l2"
KERNEL_MODULE_PROBECONF += "bcm2835-v4l2"
module_conf_bcm2835-v4l2 = "options bcm2835-v4l2 gst_v4l2src_is_broken=1"

# video camera support
VIDEO_CAMERA = "1"

RPI_EXTRA_CONFIG = "# \
Enable the onboard ALSA audio \n\
dtparam=audio=on \n\
"

# enable device mode from usb-c
ENABLE_DWC2_PERIPHERAL_raspberrypi4 = "1"

# additional memory for GPU
GPU_MEM_256 = "128"
GPU_MEM_512 = "256"
GPU_MEM_1024= "256"

MACHINE_FEATURES += "pitft"

MACHINE_GSTREAMER_1_0_PLUGIN += "gstreamer1.0-omx"

RPI_KERNEL_DEVICETREE_OVERLAYS = "\
    overlays/act-led.dtbo \
    overlays/adafruit18.dtbo \
    overlays/adau1977-adc.dtbo \
    overlays/adau7002-simple.dtbo \
    overlays/ads1015.dtbo \
    overlays/ads1115.dtbo \
    overlays/ads7846.dtbo \
    overlays/adv7282m.dtbo \
    overlays/adv728x-m.dtbo \
    overlays/akkordion-iqdacplus.dtbo \
    overlays/allo-boss2-dac-audio.dtbo \
    overlays/allo-boss-dac-pcm512x-audio.dtbo \
    overlays/allo-digione.dtbo \
    overlays/allo-katana-dac-audio.dtbo \
    overlays/allo-piano-dac-pcm512x-audio.dtbo \
    overlays/allo-piano-dac-plus-pcm512x-audio.dtbo \
    overlays/anyspi.dtbo \
    overlays/apds9960.dtbo \
    overlays/applepi-dac.dtbo \
    overlays/at86rf233.dtbo \
    overlays/audioinjector-addons.dtbo \
    overlays/audioinjector-isolated-soundcard.dtbo \
    overlays/audioinjector-ultra.dtbo \
    overlays/audioinjector-wm8731-audio.dtbo \
    overlays/audiosense-pi.dtbo \
    overlays/audremap.dtbo \
    overlays/balena-fin.dtbo \
    overlays/cma.dtbo \
    overlays/dht11.dtbo \
    overlays/dionaudio-loco.dtbo \
    overlays/dionaudio-loco-v2.dtbo \
    overlays/disable-bt.dtbo \
    overlays/disable-wifi.dtbo \
    overlays/dpi18.dtbo \
    overlays/dpi24.dtbo \
    overlays/draws.dtbo \
    overlays/dwc2.dtbo \
    overlays/dwc-otg.dtbo \
    overlays/edt-ft5406.dtbo \
    overlays/enc28j60.dtbo \
    overlays/enc28j60-spi2.dtbo \
    overlays/exc3000.dtbo \
    overlays/fe-pi-audio.dtbo \
    overlays/fsm-demo.dtbo \
    overlays/ghost-amp.dtbo \
    overlays/goodix.dtbo \
    overlays/googlevoicehat-soundcard.dtbo \
    overlays/gpio-fan.dtbo \
    overlays/gpio-ir.dtbo \
    overlays/gpio-ir-tx.dtbo \
    overlays/gpio-key.dtbo \
    overlays/gpio-no-bank0-irq.dtbo \
    overlays/gpio-no-irq.dtbo \
    overlays/gpio-poweroff.dtbo \
    overlays/gpio-shutdown.dtbo \
    overlays/hd44780-lcd.dtbo \
    overlays/hdmi-backlight-hwhack-gpio.dtbo \
    overlays/hifiberry-amp100.dtbo \
    overlays/hifiberry-amp.dtbo \
    overlays/hifiberry-dac.dtbo \
    overlays/hifiberry-dacplusadc.dtbo \
    overlays/hifiberry-dacplusadcpro.dtbo \
    overlays/hifiberry-dacplusdsp.dtbo \
    overlays/hifiberry-dacplushd.dtbo \
    overlays/hifiberry-dacplus.dtbo \
    overlays/hifiberry-digi.dtbo \
    overlays/hifiberry-digi-pro.dtbo \
    overlays/highperi.dtbo \
    overlays/hy28a.dtbo \
    overlays/hy28b-2017.dtbo \
    overlays/hy28b.dtbo \
    overlays/i2c0.dtbo \
    overlays/i2c1.dtbo \
    overlays/i2c3.dtbo \
    overlays/i2c4.dtbo \
    overlays/i2c5.dtbo \
    overlays/i2c6.dtbo \
    overlays/i2c-bcm2708.dtbo \
    overlays/i2c-gpio.dtbo \
    overlays/i2c-mux.dtbo \
    overlays/i2c-pwm-pca9685a.dtbo \
    overlays/i2c-rtc-gpio.dtbo \
    overlays/i2c-rtc.dtbo \
    overlays/i2c-sensor.dtbo \
    overlays/i2s-gpio28-31.dtbo \
    overlays/ilitek251x.dtbo \
    overlays/imx219.dtbo \
    overlays/imx290.dtbo \
    overlays/imx477.dtbo \
    overlays/iqaudio-codec.dtbo \
    overlays/iqaudio-dac.dtbo \
    overlays/iqaudio-dacplus.dtbo \
    overlays/iqaudio-digi-wm8804-audio.dtbo \
    overlays/irs1125.dtbo \
    overlays/i-sabre-q2m.dtbo \
    overlays/jedec-spi-nor.dtbo \
    overlays/justboom-both.dtbo \
    overlays/justboom-dac.dtbo \
    overlays/justboom-digi.dtbo \
    overlays/ltc294x.dtbo \
    overlays/max98357a.dtbo \
    overlays/maxtherm.dtbo \
    overlays/mbed-dac.dtbo \
    overlays/mcp23017.dtbo \
    overlays/mcp23s17.dtbo \
    overlays/mcp2515-can0.dtbo \
    overlays/mcp2515-can1.dtbo \
    overlays/mcp251xfd.dtbo \
    overlays/mcp3008.dtbo \
    overlays/mcp3202.dtbo \
    overlays/mcp342x.dtbo \
    overlays/media-center.dtbo \
    overlays/merus-amp.dtbo \
    overlays/midi-uart0.dtbo \
    overlays/midi-uart1.dtbo \
    overlays/miniuart-bt.dtbo \
    overlays/mmc.dtbo \
    overlays/mpu6050.dtbo \
    overlays/mz61581.dtbo \
    overlays/ov5647.dtbo \
    overlays/ov7251.dtbo \
    overlays/ov9281.dtbo \
    overlays/papirus.dtbo \
    overlays/pca953x.dtbo \
    overlays/pibell.dtbo \
    overlays/pifacedigital.dtbo \
    overlays/pifi-40.dtbo \
    overlays/piglow.dtbo \
    overlays/piscreen2r.dtbo \
    overlays/piscreen.dtbo \
    overlays/pisound.dtbo \
    overlays/pitft22.dtbo \
    overlays/pitft28-capacitive.dtbo \
    overlays/pitft28-resistive.dtbo \
    overlays/pitft35-resistive.dtbo \
    overlays/pps-gpio.dtbo \
    overlays/pwm-2chan.dtbo \
    overlays/pwm-ir-tx.dtbo \
    overlays/pwm.dtbo \
    overlays/qca7000.dtbo \
    overlays/rotary-encoder.dtbo \
    overlays/rpi-backlight.dtbo \
    overlays/rpi-cirrus-wm5102.dtbo \
    overlays/rpi-dac.dtbo \
    overlays/rpi-display.dtbo \
    overlays/rpi-ft5406.dtbo \
    overlays/rpi-poe.dtbo \
    overlays/rpi-proto.dtbo \
    overlays/rpi-sense.dtbo \
    overlays/rpi-tv.dtbo \
    overlays/rpivid-v4l2.dtbo \
    overlays/rra-digidac1-wm8741-audio.dtbo \
    overlays/sainsmart18.dtbo \
    overlays/sc16is750-i2c.dtbo \
    overlays/sc16is752-i2c.dtbo \
    overlays/sc16is752-spi0.dtbo \
    overlays/sc16is752-spi1.dtbo \
    overlays/sdhost.dtbo \
    overlays/sdio.dtbo \
    overlays/seeed-can-fd-hat-v1.dtbo \
    overlays/seeed-can-fd-hat-v2.dtbo \
    overlays/sh1106-spi.dtbo \
    overlays/smi-dev.dtbo \
    overlays/smi-nand.dtbo \
    overlays/smi.dtbo \
    overlays/spi0-1cs.dtbo \
    overlays/spi0-2cs.dtbo \
    overlays/spi1-1cs.dtbo \
    overlays/spi1-2cs.dtbo \
    overlays/spi1-3cs.dtbo \
    overlays/spi2-1cs.dtbo \
    overlays/spi2-2cs.dtbo \
    overlays/spi2-3cs.dtbo \
    overlays/spi3-1cs.dtbo \
    overlays/spi3-2cs.dtbo \
    overlays/spi4-1cs.dtbo \
    overlays/spi4-2cs.dtbo \
    overlays/spi5-1cs.dtbo \
    overlays/spi5-2cs.dtbo \
    overlays/spi6-1cs.dtbo \
    overlays/spi6-2cs.dtbo \
    overlays/spi-gpio35-39.dtbo \
    overlays/spi-gpio40-45.dtbo \
    overlays/spi-rtc.dtbo \
    overlays/ssd1306.dtbo \
    overlays/ssd1306-spi.dtbo \
    overlays/ssd1351-spi.dtbo \
    overlays/superaudioboard.dtbo \
    overlays/sx150x.dtbo \
    overlays/tc358743-audio.dtbo \
    overlays/tc358743.dtbo \
    overlays/tinylcd35.dtbo \
    overlays/tpm-slb9670.dtbo \
    overlays/uart0.dtbo \
    overlays/uart1.dtbo \
    overlays/uart2.dtbo \
    overlays/uart3.dtbo \
    overlays/uart4.dtbo \
    overlays/uart5.dtbo \
    overlays/udrc.dtbo \
    overlays/upstream.dtbo \
    overlays/upstream-pi4.dtbo \
    overlays/vc4-fkms-v3d.dtbo \
    overlays/vc4-kms-dsi-7inch.dtbo \
    overlays/vc4-kms-kippah-7inch.dtbo \
    overlays/vc4-kms-v3d.dtbo \
    overlays/vc4-kms-v3d-pi4.dtbo \
    overlays/vga666.dtbo \
    overlays/w1-gpio.dtbo \
    overlays/w1-gpio-pullup.dtbo \
    overlays/w5500.dtbo \
    overlays/wittypi.dtbo \
    overlays/wm8960-soundcard.dtbo \
"
