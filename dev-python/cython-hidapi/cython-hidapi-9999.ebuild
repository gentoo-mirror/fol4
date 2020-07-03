EAPI=6
PYTHON_COMPAT=(python{2_7,3_5,3_6,3_7,3_8})

inherit distutils-r1 git-r3

DEPEND=""
RDEPEND=">=dev-python/cython-0.24"

DESCRIPTION="Python wrapper for the hidapi"
HOMEPAGE="https://github.com/trezor/cython-hidapi"
LICENSE="GPL-3 BSD"
EGIT_REPO_URI="https://github.com/trezor/cython-hidapi"
EGIT_SUBMODULES=( hidapi )
SLOT="0"
KEYWORDS="~amd64"
