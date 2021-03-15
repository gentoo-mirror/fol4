# Copyright 2015 Mads
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DESCRIPTION="twofing is a daemon which runs in the background and recognizes two-finger gestures performed on a touchscreen and converts them into mouse and keyboard events."
HOMEPAGE="http://plippo.de/p/twofing"

BASE_URI="http://plippo.de/dwl/twofing"
SRC_URI="${BASE_URI}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
RESTRICT="mirror"

DEPEND="x11-libs/libX11
	x11-libs/libXtst
	x11-libs/libXi
	x11-libs/libXrandr
	x11-proto/randrproto"

src_install() {
	insinto /usr/bin
	dobin "${PN}"
}
