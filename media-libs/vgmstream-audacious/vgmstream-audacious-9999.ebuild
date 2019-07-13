# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils git-r3

DESCRIPTION="vgmstream decoder addon for Kodi"
HOMEPAGE="https://github.com/losnoco/vgmstream"

SRC_URI=""
EGIT_REPO_URI="https://github.com/losnoco/vgmstream.git"
CODENAME="Leia"
KEYWORDS="~amd64 ~x86"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

RDEPEND="media-libs/audacious-plugins"

src_configure() {
	local mycmakeargs=("-DUSE_FDKAAC=OFF")
	cmake-utils_src_configure
}
