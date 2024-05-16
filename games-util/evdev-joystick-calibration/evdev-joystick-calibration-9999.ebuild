# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( pypy3 python3_{10..13} )

inherit distutils-r1 git-r3

DESCRIPTION="Reusable constraint types to use with typing.Annotated"
HOMEPAGE="https://github.com/nick-l-o3de/evdev-joystick-calibration"

EGIT_REPO_URI="https://github.com/nick-l-o3de/evdev-joystick-calibration.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
RESTRICT="mirror"

RDEPEND=">=dev-python/evdev-1.3.0[${PYTHON_USEDEP}]"

