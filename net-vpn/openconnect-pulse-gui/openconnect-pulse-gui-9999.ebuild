# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=8
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..12} )

inherit distutils-r1

if [[ ${PV} == "9999" ]] ; then
	inherit git-r3
	EGIT_BRANCH="master"
	EGIT_REPO_URI="https://github.com/utknoxville/${PN}.git"
	SRC_URI=""
else
	SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
fi

DESCRIPTION="This script provides a wrapper around OpenConnect which allows a user to log in through a WebKitGTK2 window."
HOMEPAGE="https://github.com/utknoxville/openconnect-pulse-gui"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND="dev-python/pygobject
	net-libs/webkit-gtk:4
	"
DEPEND="${RDEPEND}"
