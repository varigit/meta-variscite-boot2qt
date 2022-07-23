# packagegroup-b2qt-embedded-tools requires openssh-sftp-server, but
# when populating the SDK this originates a conflict with ssh-server-dropbear
# required by b2qt-embedded-qt6-image: switch to ssh-server-openssh
IMAGE_FEATURES_remove += "ssh-server-dropbear"
IMAGE_FEATURES_append += "ssh-server-openssh"

# align sdk target packages to those provided by meta-toolchain-b2qt-embedded-qt6
inherit populate_b2qt_qt6_sdk
TOOLCHAIN_HOST_TASK += "nativesdk-packagegroup-b2qt-embedded-qt6-toolchain-host"
TOOLCHAIN_TARGET_TASK += "packagegroup-b2qt-embedded-qt6-toolchain-target"

IMAGE_INSTALL_append = " \
    alsa-utils \
    fbset \
    can-utils \
    coreutils \
    cryptodev-module \
    cryptodev-tests \
    dosfstools \
    e2fsprogs-mke2fs \
    ethtool \
    evtest \
    iperf3 \
    linuxptp \
    memtester \
    minicom \
    mmc-utils \
    mtd-utils-ubifs \
    nano \
    ntpdate \
    pciutils \
    ptpd \
    tar \
    udev-extraconf \
    usbutils \
    util-linux \
    v4l-utils \
    expect \
    libgpiod \
    libgpiod-tools \
    "

systemd_disable_vt () {
    rm ${IMAGE_ROOTFS}${sysconfdir}/systemd/system/getty.target.wants/getty@tty*.service
}

IMAGE_PREPROCESS_COMMAND_append = " ${@ 'systemd_disable_vt;' if bb.utils.contains('DISTRO_FEATURES', 'systemd', True, False, d) and bb.utils.contains('USE_VT', '0', True, False, d) else ''} "
