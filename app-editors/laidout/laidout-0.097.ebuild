# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="DTP, and experimental vector graphics tools"
HOMEPAGE="https://laidout.org/"
SRC_URI="https://github.com/Laidout/laidout/releases/download/${PV}/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
RESTRICT="mirror"

DEPEND="
	media-libs/libpng
	sys-libs/readline
	x11-base/xorg-server
	net-print/cups
	x11-libs/cairo
	media-libs/harfbuzz
	media-libs/imlib2
	media-libs/lcms
	dev-libs/openssl
	dev-db/sqlite
	media-libs/freetype
	media-gfx/graphicsmagick
	sys-libs/zlib
	media-libs/gegl:0.3
	media-libs/ftgl
"
RDEPEND="${DEPEND}"

DOCS=( AUTHORS COPYING ROADMAP README.md QUICKREF.html features.md )
