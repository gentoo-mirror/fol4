# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
PYTHON_COMPAT=( python{2_6,2_7,3_4} )

inherit eutils distutils-r1

if [[ ${PV} == "9999" ]] ; then
	inherit git-2
	EGIT_BRANCH="feature_asyncio_python3"
	EGIT_REPO_URI="git://github.com/moltob/${PN}.git"
	SRC_URI=""
else
	SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
fi

DESCRIPTION="A Modbus protocol stack in Python"
HOMEPAGE="https://github.com/bashwork/pymodbus"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="doc serial test"

RDEPEND="dev-python/setuptools
	dev-python/twisted-core[serial?]
	"
DEPEND="${RDEPEND}
	doc? ( dev-python/sphinx )
	test? (
		dev-python/coverage
		dev-python/mock
		dev-python/nose
		dev-python/pep8
	)
	"

DOCS=( README.rst )
