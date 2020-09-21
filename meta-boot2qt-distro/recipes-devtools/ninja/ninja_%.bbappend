do_compile_mingw32() {
        python3 ./configure.py --platform mingw
        ninja
}

do_install_mingw32() {
        install -D -m 0755  ${S}/ninja.exe ${D}${bindir}/ninja.exe
}
