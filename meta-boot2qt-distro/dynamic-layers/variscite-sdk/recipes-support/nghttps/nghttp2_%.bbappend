# Remove packages that are empty by default
PACKAGES:remove = "${PN}-client ${PN}-server"
RDEPENDS:${PN}:remove = "${PN}-client (>= ${PV}) ${PN}-server (>= ${PV})"

FILES:${PN}-client:remove = "${bindir}/h2load ${bindir}/nghttp"
FILES:${PN}-server:remove = "${bindir}/nghttpd"
