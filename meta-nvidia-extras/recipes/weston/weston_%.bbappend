# Copyright (c) 2016, NVIDIA CORPORATION.  All rights reserved.
#
# This program is free software; you can redistribute it and/or modify it
# under the terms and conditions of the GNU General Public License,
# version 2, as published by the Free Software Foundation.
#
# This program is distributed in the hope it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
# more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

LIC_FILES_CHKSUM = "file://COPYING;md5=d79ee9e66bb0f95d3386a7acae780b70 \
                    file://src/compositor.c;endline=24;md5=70efe6a96837805b300f0317a6306837"

SRC_URI = "file://${LNX_TOPDIR}/samples/wayland/weston \
           file://NVIDIA-weston-configure.patch"

FILESEXTRAPATHS_prepend := "${THISDIR}/../${PN}:"
PV = "1.11.0"

S = "${WORKDIR}/${LNX_TOPDIR}/samples/wayland/weston"
B = "${S}"

DEPENDS += "wayland-egl tegra-drivers"

PACKAGECONFIG = "egl kms libinput"

# Fix warnings by removing redundant configure flags passed to weston
EXTRA_OECONF_remove = "--enable-libinput-backend --disable-webp --disable-lcms"

#
# Compositor choices
#
# Weston with EGL support
PACKAGECONFIG[egl] = "--enable-egl,--disable-egl,virtual/egl"
# Weston on egloutput
PACKAGECONFIG[kms] = "--enable-drm-compositor,--disable-drm-compositor,drm udev mtdev"

CFLAGS += " -DWAYLAND=1 "

LDFLAGS += " -lnvidia-egl-wayland "

do_configure_prepend() {
    cd ${S}
    NOCONFIGURE=1 ./autogen.sh
    cd ${B}
}

do_install_append() {
    # create dir
    install -d ${D}/${ROOT_HOME}/.config

    sed -i 's/\/usr\/local\/bin\/weston-ivi-shell-user-interface/\/usr\/lib\/weston\/weston-ivi-shell-user-interface/g' ${S}/tools/weston.ini
    sed -i 's/\/usr\/local\/share\/weston\/background.png/\/usr\/share\/weston\/background.png/g' ${S}/tools/weston.ini
    sed -i 's/\/usr\/local\/share\/weston\/panel.png/\/usr\/share\/weston\/panel.png/g' ${S}/tools/weston.ini
    sed -i 's/\/usr\/local\/share\/weston\/tiling.png/\/usr\/share\/weston\/tiling.png/g' ${S}/tools/weston.ini
    sed -i 's/\/usr\/local\/share\/weston\/sidebyside.png/\/usr\/share\/weston\/sidebyside.png/g' ${S}/tools/weston.ini
    sed -i 's/\/usr\/local\/share\/weston\/fullscreen.png/\/usr\/share\/weston\/fullscreen.png/g' ${S}/tools/weston.ini
    sed -i 's/\/usr\/local\/share\/weston\/home.png/\/usr\/share\/weston\/home.png/g' ${S}/tools/weston.ini
    sed -i 's/\/usr\/local\/share\/weston\/random.png/\/usr\/share\/weston\/random.png/g' ${S}/tools/weston.ini

    # weston.ini
    install -m 0775 ${S}/tools/weston.ini ${D}/${ROOT_HOME}/.config
    sed -i 's/\/include/\/include\/weston/g' ${D}/usr/lib/pkgconfig/weston.pc
}

FILES_${PN} += " ${ROOT_HOME}/* ${ROOT_HOME}/.config "

ALLOW_EMPTY_${PN}-examples = "1"
