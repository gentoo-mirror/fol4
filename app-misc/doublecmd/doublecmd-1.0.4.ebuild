# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils xdg-utils

ABBREV="doublecmd"
DESCRIPTION="Cross Platform file manager."
HOMEPAGE="https://doublecmd.sourceforge.io/"
SRC_URI="mirror://sourceforge/${ABBREV}/${ABBREV}-${PV}-src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RESTRICT="mirror"

DEPEND=">=dev-lang/lazarus-1.8"
RDEPEND="
	${DEPEND}
	sys-apps/dbus
	dev-libs/glib
	sys-libs/ncurses
	x11-libs/libX11
	>=dev-qt/qtcore-5.6
	>=dev-libs/libqt5pas-1.2.8
"


PATCHES=( "${FILESDIR}"/${ABBREV}-build.patch )

HOME="${PORTAGE_BUILDDIR}/homedir"
export HOME
src_compile(){
	# Set temporary HOME for lazarus primary config directory
	  ./build.sh beta qt5 || die

}

src_install(){
./install/linux/install.sh --install-prefix="${D}" 
}

pkg_postinst() {
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
}
