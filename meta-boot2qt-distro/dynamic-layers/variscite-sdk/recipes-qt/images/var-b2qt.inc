# packagegroup-b2qt-embedded-tools requires openssh-sftp-server, but
# when populating the SDK this originates a conflict with ssh-server-dropbear
# required by b2qt-embedded-qt6-image: switch to ssh-server-openssh
IMAGE_FEATURES:remove = "ssh-server-dropbear"
IMAGE_FEATURES:append = "ssh-server-openssh"

# align sdk target packages to those provided by meta-toolchain-b2qt-embedded-qt6
TOOLCHAIN_HOST_TASK += "nativesdk-packagegroup-b2qt-embedded-qt6-toolchain-host"
TOOLCHAIN_TARGET_TASK += "\
    packagegroup-b2qt-embedded-toolchain-target \
    packagegroup-qt6-modules \
"

# Add machine learning packagegroup
ML_PKGS ?= ""
ML_PKGS:mx8-nxp-bsp = "packagegroup-var-ml"

# Add security packages
SEC_PKGS = "packagegroup-var-security"

# Add docker packages for Variscite SoMs with eMMC
DOCKER_PKGS			?= ""
DOCKER_PKGS:mx8-nxp-bsp		= "${@bb.utils.contains('DISTRO_FEATURES', 'virtualization', 'docker-ce python3-docker-compose', '', d)}"
DOCKER_PKGS:mx9-nxp-bsp		= "${@bb.utils.contains('DISTRO_FEATURES', 'virtualization', 'docker-ce python3-docker-compose', '', d)}"

IMAGE_INSTALL:append = " \
    alsa-utils \
    fbset \
    can-utils \
    connman-wait-online \
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
    ${SEC_PKGS} \
    ${DOCKER_PKGS} \
    "

systemd_disable_vt () {
    rm ${IMAGE_ROOTFS}${sysconfdir}/systemd/system/getty.target.wants/getty@tty*.service
}

IMAGE_PREPROCESS_COMMAND:append = " ${@ 'systemd_disable_vt;' if bb.utils.contains('DISTRO_FEATURES', 'systemd', True, False, d) and bb.utils.contains('USE_VT', '0', True, False, d) else ''} "