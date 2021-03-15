# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v3

EAPI=7
PYTHON_COMPAT=( python{3_5,3_6,3_7} )
inherit distutils-r1 git-r3

DESCRIPTION="Low-level communication layer for PRAW 4+."
HOMEPAGE="https://github.com/praw-dev/prawcore"

EGIT_REPO_URI="https://github.com/praw-dev/prawcore.git"
EGIT_COMMIT="v${PV}"

RDEPEND="dev-python/praw[${PYTHON_USEDEP}]"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
