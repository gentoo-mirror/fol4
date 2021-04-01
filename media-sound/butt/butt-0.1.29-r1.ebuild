# Copyright 1999-2020 Christian Affolter <c.affolter@purplehaze.ch>
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit eutils flag-o-matic xdg-utils

DESCRIPTION="butt is an easy to use, multi OS streaming tool"
HOMEPAGE="http://danielnoethen.de/butt/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

RESTRICT="mirror"
LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="amd64"
IUSE="aac flac mp3 ogg opus vorbis"

DEPEND="aac? ( media-libs/fdk-aac )
		flac? ( media-libs/flac )
		vorbis? ( media-libs/libogg
				  media-libs/libvorbis )
		opus? ( media-libs/opus )
		media-libs/portaudio
		mp3? ( media-sound/lame )
		x11-libs/fltk"

RDEPEND="${DEPEND}"

src_prepare() {
	# Fix invalid Desktop Menu category
	# https://specifications.freedesktop.org/menu-spec/latest/apa.html
	sed -i -e 's|\(Categories\)=Sound|\1=AudioVideo;Audio|' \
		usr/share/applications/${PN}.desktop || die 'sed failed'
	eapply "${FILESDIR}/butt-audacious.patch"
	default
}

src_configure() {
	append-ldflags "$(fltk-config --ldflags)"
	default
}

src_install() {
	domenu "usr/share/applications/${PN}.desktop"

	for size in 16 22 24 32 48 64 96 128 256 512; do
		newicon -s ${size} "icons/icon_${size}x${size}.png" "${PN}.png"
	done

	newicon -s scalable "icons/icon_scalable.svg" "${PN}.svg"

	default
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
