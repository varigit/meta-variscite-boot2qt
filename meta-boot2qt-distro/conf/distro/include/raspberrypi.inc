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

IMAGE_FSTYPES += "ext3 rpi-sdimg"

QBSP_IMAGE_CONTENT ?= "\
    ${IMAGE_LINK_NAME}.img \
    ${IMAGE_LINK_NAME}.conf \
    "

MACHINE_EXTRA_INSTALL += "\
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

MACHINE_FEATURES += "pitft"

MACHINE_GSTREAMER_1_0_PLUGIN += "gstreamer1.0-omx"

RPI_KERNEL_DEVICETREE_OVERLAYS = "\
    overlays/act-led.dtbo \
    overlays/adau1977-adc.dtbo \
    overlays/adau7002-simple.dtbo \
    overlays/ads1015.dtbo \
    overlays/ads1115.dtbo \
    overlays/ads7846.dtbo \
    overlays/adv7282m.dtbo \
    overlays/adv728x-m.dtbo \
    overlays/akkordion-iqdacplus.dtbo \
    overlays/allo-boss-dac-pcm512x-audio.dtbo \
    overlays/allo-digione.dtbo \
    overlays/allo-katana-dac-audio.dtbo \
    overlays/allo-piano-dac-pcm512x-audio.dtbo \
    overlays/allo-piano-dac-plus-pcm512x-audio.dtbo \
    overlays/applepi-dac.dtbo \
    overlays/at86rf233.dtbo \
    overlays/audioinjector-addons.dtbo \
    overlays/audioinjector-ultra.dtbo \
    overlays/audioinjector-wm8731-audio.dtbo \
    overlays/audiosense-pi.dtbo \
    overlays/audremap.dtbo \
    overlays/balena-fin.dtbo \
    overlays/bmp085_i2c-sensor.dtbo \
    overlays/dht11.dtbo \
    overlays/dionaudio-loco.dtbo \
    overlays/dionaudio-loco-v2.dtbo \
    overlays/disable-bt.dtbo \
    overlays/disable-wifi.dtbo \
    overlays/dpi18.dtbo \
    overlays/dpi24.dtbo \
    overlays/draws.dtbo \
    overlays/dwc-otg.dtbo \
    overlays/dwc2.dtbo \
    overlays/enc28j60.dtbo \
    overlays/enc28j60-spi2.dtbo \
    overlays/exc3000.dtbo \
    overlays/fe-pi-audio.dtbo \
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
    overlays/hifiberry-amp.dtbo \
    overlays/hifiberry-dac.dtbo \
    overlays/hifiberry-dacplus.dtbo \
    overlays/hifiberry-dacplusadc.dtbo \
    overlays/hifiberry-digi.dtbo \
    overlays/hifiberry-digi-pro.dtbo \
    overlays/hy28a.dtbo \
    overlays/hy28b.dtbo \
    overlays/hy28b-2017.dtbo \
    overlays/i-sabre-q2m.dtbo \
    overlays/i2c-bcm2708.dtbo \
    overlays/i2c-gpio.dtbo \
    overlays/i2c-mux.dtbo \
    overlays/i2c-pwm-pca9685a.dtbo \
    overlays/i2c-rtc.dtbo \
    overlays/i2c-rtc-gpio.dtbo \
    overlays/i2c-sensor.dtbo \
    overlays/i2c0.dtbo \
    overlays/i2c0-bcm2708.dtbo \
    overlays/i2c1.dtbo \
    overlays/i2c1-bcm2708.dtbo \
    overlays/i2c3.dtbo \
    overlays/i2c4.dtbo \
    overlays/i2c5.dtbo \
    overlays/i2c6.dtbo \
    overlays/i2s-gpio28-31.dtbo \
    overlays/ilitek251x.dtbo \
    overlays/iqaudio-codec.dtbo \
    overlays/iqaudio-dac.dtbo \
    overlays/iqaudio-dacplus.dtbo \
    overlays/iqaudio-digi-wm8804-audio.dtbo \
    overlays/jedec-spi-nor.dtbo \
    overlays/justboom-dac.dtbo \
    overlays/justboom-digi.dtbo \
    overlays/ltc294x.dtbo \
    overlays/max98357a.dtbo \
    overlays/mbed-dac.dtbo \
    overlays/mcp23017.dtbo \
    overlays/mcp23s17.dtbo \
    overlays/mcp2515-can0.dtbo \
    overlays/mcp2515-can1.dtbo \
    overlays/mcp3008.dtbo \
    overlays/mcp3202.dtbo \
    overlays/mcp342x.dtbo \
    overlays/media-center.dtbo \
    overlays/midi-uart0.dtbo \
    overlays/midi-uart1.dtbo \
    overlays/miniuart-bt.dtbo \
    overlays/mmc.dtbo \
    overlays/mpu6050.dtbo \
    overlays/mz61581.dtbo \
    overlays/ov5647.dtbo \
    overlays/papirus.dtbo \
    overlays/pi3-act-led.dtbo \
    overlays/pi3-disable-bt.dtbo \
    overlays/pi3-disable-wifi.dtbo \
    overlays/pi3-miniuart-bt.dtbo \
    overlays/pibell.dtbo \
    overlays/piglow.dtbo \
    overlays/piscreen.dtbo \
    overlays/piscreen2r.dtbo \
    overlays/pisound.dtbo \
    overlays/pitft22.dtbo \
    overlays/pitft28-capacitive.dtbo \
    overlays/pitft28-resistive.dtbo \
    overlays/pitft35-resistive.dtbo \
    overlays/pps-gpio.dtbo \
    overlays/pwm.dtbo \
    overlays/pwm-2chan.dtbo \
    overlays/pwm-ir-tx.dtbo \
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
    overlays/rra-digidac1-wm8741-audio.dtbo \
    overlays/sc16is750-i2c.dtbo \
    overlays/sc16is752-i2c.dtbo \
    overlays/sc16is752-spi1.dtbo \
    overlays/sdhost.dtbo \
    overlays/sdio.dtbo \
    overlays/sdtweak.dtbo \
    overlays/smi.dtbo \
    overlays/smi-dev.dtbo \
    overlays/smi-nand.dtbo \
    overlays/spi-gpio35-39.dtbo \
    overlays/spi-gpio40-45.dtbo \
    overlays/spi-rtc.dtbo \
    overlays/spi0-cs.dtbo \
    overlays/spi0-hw-cs.dtbo \
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
    overlays/ssd1306.dtbo \
    overlays/superaudioboard.dtbo \
    overlays/sx150x.dtbo \
    overlays/tc358743.dtbo \
    overlays/tc358743-audio.dtbo \
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
    overlays/vc4-fkms-v3d.dtbo \
    overlays/vc4-kms-kippah-7inch.dtbo \
    overlays/vc4-kms-v3d.dtbo \
    overlays/vga666.dtbo \
    overlays/w1-gpio.dtbo \
    overlays/w1-gpio-pullup.dtbo \
    overlays/wittypi.dtbo \
    "
