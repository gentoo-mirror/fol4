# Copyright 1999-2022 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v3

EAPI=7
PYTHON_COMPAT=( python{3_8,3_9,3_10,3_11} )
inherit distutils-r1 git-r3

DESCRIPTION="This is a fork of Dan Lenski's SCSI library, rewritten to be compatible with Python3"
HOMEPAGE="https://github.com/crypto-universe/py3_sg"

EGIT_REPO_URI="https://github.com/crypto-universe/py3_sg.git"
# EGIT_COMMIT="v${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
