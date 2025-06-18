# Copyright 1999-2022 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v3

EAPI=8
DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python{3_8,3_9,3_10,3_11,3_12} )
inherit distutils-r1 git-r3

DESCRIPTION="WD My Passport Drive Hardware Encryption Utility for Linux"
HOMEPAGE="https://github.com/0-duke/wdpassport-utils"

EGIT_REPO_URI="https://github.com/0-duke/wdpassport-utils.git"
# EGIT_COMMIT="v${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RDEPEND="dev-python/py_sg[${PYTHON_USEDEP}]
         dev-python/pyudev[${PYTHON_USEDEP}]"
