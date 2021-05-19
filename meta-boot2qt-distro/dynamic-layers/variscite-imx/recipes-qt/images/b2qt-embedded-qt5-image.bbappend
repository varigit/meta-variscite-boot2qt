
IMAGE_INSTALL_append = " \
    alsa-utils \
    boot2qt-demo-camera \
    can-utils \
    mtd-utils \
    mtd-utils-ubifs \
    dosfstools \
    e2fsprogs-mke2fs \
    evtest \
    imx-kobs \
    iperf3 \
    pciutils \
    pulseaudio-misc \
    pulseaudio-server \
    tar \
    udev-extraconf \
    usbutils \
    expect \
    file \
    "

systemd_disable_vt () {
    rm ${IMAGE_ROOTFS}${sysconfdir}/systemd/system/getty.target.wants/getty@tty*.service
}

IMAGE_PREPROCESS_COMMAND_append = " ${@ 'systemd_disable_vt;' if bb.utils.contains('DISTRO_FEATURES', 'systemd', True, False, d) and bb.utils.contains('USE_VT', '0', True, False, d) else ''} "
