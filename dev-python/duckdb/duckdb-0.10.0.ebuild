# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_9 python3_1{0,1,2} )
DISTUTILS_USE_PEP517=setuptools
DISTUTILS_EXT=1
inherit distutils-r1 pypi

DESCRIPTION="DuckDB embedded database"
SRC_URI="$(pypi_sdist_url "${PN^}" "${PV}")"
HOMEPAGE="https://www.duckdb.org"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

IUSE=""
RDEPEND="dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/pybind11[${PYTHON_USEDEP}]
	dev-python/pandas[${PYTHON_USEDEP}]
	dev-python/pyarrow[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}"

RESTRICT="mirror"

DUCKDB_BINARY_DIR="/usr/lib64"


distutils_enable_tests pytest

src_install() {
	distutils-r1_src_install
	rm -vr "${D}/usr/share/doc/duckdb-${PV}"
}
