# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{7,8,9,10,11} pypy3 )

inherit distutils-r1

DISTUTILS_USE_PEP517=setuptools

DESCRIPTION="A multi-process batch flac converter. For music lovers with large collections :-)"
HOMEPAGE="https://github.com/ZivaVatra/flac2all/"
SRC_URI="mirror://pypi/${P:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~riscv ~s390 ~sparc ~x86 ~amd64-linux ~x86-linux ~x64-macos"
IUSE=""

RDEPEND="
	net-libs/zeromq
	media-libs/flac
"

PATCHES=( "${FILESDIR}"/${P}-version_logic.patch )

