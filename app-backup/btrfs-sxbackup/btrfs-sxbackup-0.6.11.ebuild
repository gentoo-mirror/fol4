# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python3_{3,4,5,6,7} )
DISTUTILS_SINGLE_IMPL=yes

inherit distutils-r1 git-r3

DESCRIPTION="Incremental btrfs snapshot backups with push/pull support via SSH"
HOMEPAGE="https://github.com/masc3d/btrfs-sxbackup"
EGIT_REPO_URI="https://github.com/masc3d/btrfs-sxbackup.git"
EGIT_COMMIT="${PV}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="sys-fs/btrfs-progs sys-apps/pv app-arch/lzop"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

