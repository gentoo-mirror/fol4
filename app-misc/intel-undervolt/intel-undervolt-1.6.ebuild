# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Undervolt Intel CPUs under Linux"
HOMEPAGE="https://github.com/kitsunyan/intel-undervolt"
SRC_URI="https://codeload.github.com/kitsunyan/${PN}/tar.gz/${PV} -> ${PN}-${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror"

RDEPEND=""
DEPEND="${RDEPEND}"
DOCS=( README.md )

