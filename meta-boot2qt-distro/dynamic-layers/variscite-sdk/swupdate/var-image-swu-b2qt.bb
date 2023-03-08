DESCRIPTION = "Example compound image for Variscite boards"
SECTION = ""

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

inherit swupdate

FILESEXTRAPATHS:prepend := "${COREBASE}/../meta-variscite-sdk/dynamic-layers/swupdate/var-image-swu:"

# Note: sw-description is mandatory
SRC_URI = " \
	file://sw-description \
	file://update.sh \
"

# IMAGE_DEPENDS: list of Yocto images that contains a root filesystem
# it will be ensured they are built before creating swupdate image
IMAGE_DEPENDS = "var-image-swupdate-b2qt"

# SWUPDATE_IMAGES: list of images that will be part of the compound image
# the list can have any binaries - images must be in the DEPLOY directory
SWUPDATE_IMAGES = " \
	var-image-swupdate-b2qt \
"

# Images can have multiple formats - define which image must be
# taken to be put in the compound image
SWUPDATE_IMAGES_FSTYPES[var-image-swupdate-b2qt] = ".tar.gz"

do_patch_swdescription() {
	sed -i 's/var-image-swupdate-/var-image-swupdate-b2qt-/' ${WORKDIR}/sw-description
}

python do_patch:append() {
    bb.build.exec_func('do_patch_swdescription', d)
}
