# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7

PYTHON_COMPAT=( python{3_8,3_9,3_10} pypy3 )
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

