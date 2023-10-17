# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake git-r3

DESCRIPTION="a multi-system chiptune tracker compatible with DefleMask modules"
HOMEPAGE="https://github.com/tildearrow/furnace/"
# SRC_URI="http://downloads.xiph.org/releases/${PN}/${P}.tar.gz"

EGIT_REPO_URI="https://github.com/tildearrow/furnace.git"

LICENSE="GPL-2"
SLOT="0"
# KEYWORDS=""
IUSE="jack"

RDEPEND="
	media-libs/libogg
"
DEPEND="${RDEPEND}
	jack? ( media-sound/jack )
	dev-libs/libfmt
	media-libs/alsa-lib
	media-libs/freetype
	media-libs/libsdl2
	media-libs/libsndfile
	media-libs/portaudio
	media-libs/mesa
	media-libs/rtmidi
	media-sound/pulseaudio
	sci-libs/fftw
	sys-libs/zlib
"

src_configure() {
    local mycmakeargs=(
    	-DSYSTEM_FFTW=ON
    	-DSYSTEM_FMT=ON
    	-DSYSTEM_FREETYPE=ON
    	-DSYSTEM_LIBSNDFILE=ON
    	-DSYSTEM_PORTAUDIO=ON
    	-DSYSTEM_RTMIDI=ON
    	-DSYSTEM_ZLIB=ON
    	-DSYSTEM_SDL2=ON
		-DWITH_JACK="$(usex jack)"
    )
    cmake_src_configure
}
