# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{2_7,3_3,3_4,3_5} )
inherit distutils-r1 git-r3

# S="${WORKDIR}"/${MY_P}

EGIT_REPO_URI="https://github.com/stevemarple/python-MCP342x.git"
EGIT_COMMIT="v${PV}"

DESCRIPTION="A Python module to control the GPIO on a Raspberry Pi"
HOMEPAGE=""
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

