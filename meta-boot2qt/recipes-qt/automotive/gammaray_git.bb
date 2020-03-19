SUMMARY = "GammaRay Qt introspection probe"
HOMEPAGE = "http://www.kdab.com/gammaray"

LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://LICENSE.GPL.txt;md5=7020efa50785f41b29f7229ba36ce169"

inherit cmake_qt5

SRC_URI = "git://github.com/KDAB/GammaRay;branch=${BRANCH}"

BRANCH = "5.15"
SRCREV = "ec9fe40808e094b3ee6283256ae18f1a3bb95bb7"
PV = "${BRANCH}+git${SRCPV}"

DEPENDS = "qtdeclarative qtlocation qtsvg qttools qtconnectivity qt3d qtivi qtscxml qtscxml-native \
           ${@bb.utils.contains("DISTRO_FEATURES", "wayland", "qtwayland", "", d)} \
           elfutils"

S = "${WORKDIR}/git"

EXTRA_OECMAKE += " -DGAMMARAY_BUILD_UI=OFF -DGAMMARAY_CORE_ONLY_LAUNCHER=ON"

FILES_${PN}-dev += " \
    /usr/lib/cmake/* \
    /usr/mkspecs/modules/* \
"
FILES_${PN}-dbg += " \
    /usr/lib/.debug/* \
    /usr/lib/gammaray/*/*/.debug \
    /usr/lib/gammaray/*/*/styles/.debug \
"
