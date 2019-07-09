# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v3

EAPI=5
PYTHON_COMPAT=( python{3_5,3_6,3_7} )
inherit distutils-r1 git-r3

DESCRIPTION="PRAW, an acronym for \"Python Reddit API Wrapper\", is a python package that allows for simple access to reddit\'s API."
HOMEPAGE="https://github.com/praw-dev/praw"

EGIT_REPO_URI="https://github.com/praw-dev/praw.git"
EGIT_COMMIT="v${PV}"

RDEPEND="dev-python/decorator[${PYTHON_USEDEP}]
		dev-python/requests[${PYTHON_USEDEP}]
		<dev-python/prawcore-0.15[${PYTHON_USEDEP}]"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
