# Copyright owners: Gentoo Foundation
#                   Arfrever Frehtes Taifersar Arahesis
#                   madsl
# Distributed under the terms of the GNU General Public License v2

EAPI="5"
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3,3_4,3_5} )

inherit distutils-r1

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

python_configure_all() {
	append-cxxflags -fno-strict-aliasing
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

