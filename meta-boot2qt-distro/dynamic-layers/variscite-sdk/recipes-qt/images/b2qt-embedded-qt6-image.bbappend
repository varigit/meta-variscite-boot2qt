# Add machine learning packagegroup
ML_PKGS ?= ""
ML_PKGS:mx8 = "packagegroup-var-ml"

IMAGE_INSTALL:append = " \
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
    ${ML_PKGS} \
    "

systemd_disable_vt () {
    rm ${IMAGE_ROOTFS}${sysconfdir}/systemd/system/getty.target.wants/getty@tty*.service
}

IMAGE_PREPROCESS_COMMAND:append = " ${@ 'systemd_disable_vt;' if bb.utils.contains('DISTRO_FEATURES', 'systemd', True, False, d) and bb.utils.contains('USE_VT', '0', True, False, d) else ''} "
