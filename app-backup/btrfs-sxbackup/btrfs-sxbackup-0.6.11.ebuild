# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..12} )
DISTUTILS_USE_SETUPTOOLS=rdepend

inherit git-r3 distutils-r1

DESCRIPTION="Incremental btrfs snapshot backups with push/pull support via SSH"
HOMEPAGE="https://github.com/masc3d/btrfs-sxbackup"
EGIT_REPO_URI="https://github.com/masc3d/btrfs-sxbackup.git"
EGIT_COMMIT="${PV}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="sys-fs/btrfs-progs sys-apps/pv app-arch/lzop"
DEPEND="${RDEPEND} ${PYTHON_DEPS}"
