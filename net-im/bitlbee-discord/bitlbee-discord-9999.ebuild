# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils autotools git-2

DESCRIPTION="Discord protocol plugin for BitlBee"
HOMEPAGE="https://github.com/sm00th/bitlbee-discord"
EGIT_REPO_URI="https://github.com/sm00th/bitlbee-discord.git"

LICENSE="GPL-2 LGPL-2.1 BSD-2"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="
	dev-libs/glib:2
	dev-libs/libgpg-error
	>=net-im/bitlbee-3.2.1[plugins]"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	eautoreconf
}

src_install() {
	default
	prune_libtool_files
}
