############################################################################
##
## Copyright (C) 2016 The Qt Company Ltd.
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

# Maintained by Variscite Ltd. (2025)
# Modifications by Variscite Ltd. (2025)
# - Replace Google Fonts URL with a stable Variscite mirror for Open_Sans.zip
# - Update license file reference
# - Remove BB_STRICT_CHECKSUM to enforce integrity checks
#
# These modifications are released under the same license as the original
# file.

SUMMARY = "Open Sans Fonts"
SECTION = "fonts"
HOMEPAGE = "https://fonts.google.com/"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/Apache-2.0;md5=89aea4e17d99a7cacdbeed46a0096b10"

INHIBIT_DEFAULT_DEPS = "1"

inherit allarch fontcache

SRC_URI = "https://variscite-public.nyc3.cdn.digitaloceanspaces.com/mirror/sources/Open_Sans.zip"
SRC_URI[md5sum] = "603a6be36f1576a7219f0f992b03ce1f"
SRC_URI[sha256sum] = "8e1b5760267934e3e0c497e6401e958fa1562e6b761e6bb22b5a40218c20c331"

do_install() {
    install -m 0755 -d ${D}${datadir}/fonts/truetype/opensans
    install -m 0644 ${WORKDIR}/*.ttf ${D}${datadir}/fonts/truetype/opensans
}

PACKAGES = "${PN}"
FILES_${PN} += "${datadir}/fonts/truetype/opensans"
