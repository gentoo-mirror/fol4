# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7
PYTHON_COMPAT=( python{2_7,3_5,3_6,3_7,3_8} )

inherit distutils-r1
DISTUTILS_USE_SETUPTOOLS=rdepend

if [[ ${PV} == "9999" ]] ; then
	inherit git-r3
	EGIT_BRANCH="master"
	EGIT_REPO_URI="https://github.com/riptideio/${PN}.git"
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
