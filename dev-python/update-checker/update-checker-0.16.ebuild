# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v3

EAPI=5
PYTHON_COMPAT=( python{3_5,3_6,3_7} )
inherit distutils-r1 git-r3

DESCRIPTION="A python module that will check for package updates."
HOMEPAGE="https://github.com/bboe/update_checker"

EGIT_REPO_URI="https://github.com/bboe/update_checker.git"
EGIT_COMMIT="v${PV}"

LICENSE="BryceBoe"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
