# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake git-r3

DESCRIPTION="vgmstream decoder plugin for audacious"
HOMEPAGE="https://github.com/losnoco/vgmstream"

SRC_URI=""
EGIT_REPO_URI="https://github.com/losnoco/vgmstream.git"
KEYWORDS="~amd64 ~x86"

LICENSE="public-domain"
SLOT="0"
IUSE=""

RDEPEND="media-plugins/audacious-plugins"

