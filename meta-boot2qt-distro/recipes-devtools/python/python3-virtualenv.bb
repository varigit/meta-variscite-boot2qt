SUMMARY = "Virtual Python Environment builder"
HOMEPAGE = "http://github.com/gitpython-developers/GitPython"
SECTION = "devel/python"
LICENSE = "BSD-3-Clause"
LIC_FILES_CHKSUM = "file://LICENSE.txt;md5=51910050bd6ad04a50033f3e15d6ce43"

PV="15.1.0"
SRC_URI = "https://files.pythonhosted.org/packages/source/v/virtualenv/virtualenv-15.1.0.tar.gz"

SRC_URI[md5sum] = "44e19f4134906fe2d75124427dc9b716"
SRC_URI[sha256sum] = "02f8102c2436bb03b3ee6dede1919d1dac8a427541652e5ec95171ec8adbc93a"

UPSTREAM_CHECK_URI = "https://pypi.python.org/pypi/virtualenv/"
UPSTREAM_CHECK_REGEX = "/virtualenv/(?P<pver>(\d+[\.\-_]*)+)"

S = "${WORKDIR}/virtualenv-${PV}"

BBCLASSEXTEND = "native nativesdk"

inherit setuptools3

