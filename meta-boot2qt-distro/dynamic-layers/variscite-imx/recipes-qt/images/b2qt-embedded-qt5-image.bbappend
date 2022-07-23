# packagegroup-b2qt-embedded-tools requires openssh-sftp-server, but
# when populating the SDK this originates a conflict with ssh-server-dropbear
# required by b2qt-embedded-qt5-image: switch to ssh-server-openssh
IMAGE_FEATURES_remove += "ssh-server-dropbear"
IMAGE_FEATURES_append += "ssh-server-openssh"

# align sdk target packages to those provided by meta-toolchain-b2qt-embedded-qt5
inherit populate_b2qt_qt5_sdk
TOOLCHAIN_HOST_TASK += "nativesdk-packagegroup-b2qt-embedded-qt5-toolchain-host"
TOOLCHAIN_TARGET_TASK += "packagegroup-b2qt-embedded-qt5-toolchain-target"

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
