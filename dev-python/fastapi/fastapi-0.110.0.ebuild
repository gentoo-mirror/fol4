# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{7,8,9,10,11,12} pypy3 )
PYTHON_REQ_USE="threads(+)"

inherit distutils-r1 pypi

DISTUTILS_USE_PEP517=yes

DESCRIPTION="FastAPI framework, high performance, easy to learn, fast to code, ready for production"
HOMEPAGE="https://fastapi.tiangolo.com/"
# SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~riscv ~s390 ~sparc ~x86 ~amd64-linux ~x86-linux ~x64-macos"
IUSE=""

RESTRICT="mirror"

RDEPEND="
	<dev-python/starlette-0.14.1[${PYTHON_USEDEP}]
	dev-python/pydantic[${PYTHON_USEDEP}]
"
