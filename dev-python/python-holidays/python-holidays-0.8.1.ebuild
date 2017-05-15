# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v3

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3,3_4,3_5} )
inherit distutils-r1 git-r3

DESCRIPTION="Generate and work with holidays in Python"
HOMEPAGE="https://pypi.python.org/pypi/holidays"

EGIT_REPO_URI="https://github.com/ryanss/python-holidays.git"
EGIT_COMMIT="v${PV}"

DEPEND="dev-python/python-dateutil[${PYTHON_USEDEP}]"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
