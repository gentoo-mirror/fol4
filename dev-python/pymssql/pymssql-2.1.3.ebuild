# Copyright owners: Gentoo Foundation
#                   Arfrever Frehtes Taifersar Arahesis
#                   madsl
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python{3_8,3_9,3_10} pypy3 )

inherit distutils-r1 flag-o-matic

DESCRIPTION="DB-API interface to Microsoft SQL Server for Python"
HOMEPAGE="http://pymssql.org/ https://github.com/pymssql/pymssql https://pypi.python.org/pypi/pymssql"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="*"
RESTRICT="mirror"
IUSE=""

RDEPEND="=dev-db/freetds-0.95.95[mssql]"
DEPEND="${RDEPEND}
	dev-python/cython[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]"

DOCS="ChangeLog"

python_compile() {
	if ! python_is_python3; then
		local CFLAGS="${CFLAGS}"
		local CXXFLAGS="${CXXFLAGS}"
		append-flags -fno-strict-aliasing
	fi

	# Python gets confused when it is in sys.path before build.
	local PYTHONPATH=
	export PYTHONPATH

	distutils-r1_python_compile
}

src_prepare() {
	distutils-r1_src_prepare

	# Require not setuptools-git.
	sed -e "/setup_requires=\['setuptools_git'\]/d" -i setup.py

	# Force regeneration of Cython-generated files.
	rm _mssql.c pymssql.c

	# Delete internal copy of dev-db/freetds.
	rm -r freetds
}

