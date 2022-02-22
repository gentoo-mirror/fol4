# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=(python3_{8..10})
DISTUTILS_USE_SETUPTOOLS=pyproject.toml
inherit git-r3 distutils-r1

DESCRIPTION="CLI for Microsoft IntelliMouse"
HOMEPAGE="https://github.com/K-Visscher/intellimouse-ctl/"
EGIT_REPO_URI="https://github.com/K-Visscher/intellimouse-ctl/"
LICENSE="GPL-3"
RESTRICT="test"

KEYWORDS="~x86 ~amd64"
SLOT="0"
IUSE=""
RDEPEND="$(python_gen_cond_dep '
	>=dev-python/cython-hidapi-9999[${PYTHON_USEDEP}]')
"
DEPEND="${RDEPEND}"

python_check_deps() {
    has_version ">=dev-python/cython-hidapi-9999[${PYTHON_USEDEP}]"
}


