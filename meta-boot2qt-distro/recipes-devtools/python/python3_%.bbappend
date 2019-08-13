# We need to install the python3 binary into the sysroot to let qtivi install that binary
# into the correct location.
# We can't install it directly into ${bindir} as this would be picked up by other recipes
# and produce a lot of errors. Instead put it inside a qt5 folder where only qtivi picks it up
# This is a workaround and needs to be replaced by a proper solution discussed here:
# https://bugreports.qt.io/browse/AUTOSUITE-176
sysroot_stage_all_append_class-nativesdk () {
    sysroot_stage_dir ${D}${bindir} ${SYSROOT_DESTDIR}${bindir}/qt5
}
