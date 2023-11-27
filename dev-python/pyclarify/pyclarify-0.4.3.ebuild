# Copyright 1999-2022 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7
PYTHON_COMPAT=( python3_{8..12} )
RESTRICT="mirror"

inherit distutils-r1 pypi

if [[ ${PV} == "9999" ]] ; then
    inherit git-r3
    EGIT_BRANCH="main"
    EGIT_REPO_URI="https://github.com/clarify/${PN}.git"
fi

DISTUTILS_USE_PEP517=setuptools
DESCRIPTION="PyClarify helps users of Clarify to easily read, write and manipulate data in Clarify."
HOMEPAGE="https://github.com/clarify/pyclarify"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

# S="${WORKDIR}/${P/-/_}"