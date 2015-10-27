# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v3

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3,3_4,3_5} )
inherit distutils-r1 git-r3

DESCRIPTION="PRAW, an acronym for \"Python Reddit API Wrapper\", is a python package that allows for simple access to reddit\'s API."
HOMEPAGE="https://github.com/praw-dev/praw"

EGIT_REPO_URI="https://github.com/praw-dev/praw.git"
EGIT_COMMIT="v${PV}"

RDEPEND="dev-python/decorator[${PYTHON_USEDEP}]
		python_targets_python2_7? ( dev-python/six )
		dev-python/requests[${PYTHON_USEDEP}]"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
