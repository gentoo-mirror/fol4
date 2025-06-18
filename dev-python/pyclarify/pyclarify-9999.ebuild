# Copyright 1999-2022 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=8
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{8..12} )
RESTRICT="mirror"

inherit distutils-r1

if [[ ${PV} == "9999" ]] ; then
    inherit git-r3
    EGIT_BRANCH="main"
    EGIT_REPO_URI="https://github.com/clarify/${PN}.git"
    SRC_URI=""
else
    SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
fi

DESCRIPTION="PyClarify helps users of Clarify to easily read, write and manipulate data in Clarify."
HOMEPAGE="https://github.com/clarify/pyclarify"
RDEPEND="<dev-python/pydantic-2[${PYTHON_USEDEP}]"
LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

# S="${WORKDIR}/${P/-/_}"
