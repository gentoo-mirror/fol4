# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# Actually not use cmake, use it manually due to weird dependency handling
inherit git-r3

DESCRIPTION="vgmstream - A library for playback of various streamed audio formats used in video games."
HOMEPAGE="https://github.com/losnoco/vgmstream"

SRC_URI=""
EGIT_REPO_URI="https://github.com/losnoco/vgmstream.git"
KEYWORDS="~amd64 ~x86"

LICENSE="public-domain"
SLOT="0"
IUSE=""

DEPEND="media-video/ffmpeg
		media-plugins/audacious-plugins"

RESTRICT="network-sandbox"

# emerge with FEATURES=-network-sandbox

#må flytte mappen dependencies

src_configure() {
	mkdir "${S}/build"
	cd "${S}/build"
	cmake -DCMAKE_INSTALL_PREFIX=/usr ..
}

src_compile() {
	cd "${S}/build"
	emake
}

src_install() {
	cd "${S}/build"
	emake DESTDIR="${D}" install
}
