# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils xdg-utils

ABBREV="doublecmd"
DESCRIPTION="Cross Platform file manager."
HOMEPAGE="http://${ABBREV}.sourceforge.net/"
SRC_URI="mirror://sourceforge/${ABBREV}/${ABBREV}-${PV}-src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="gtk qt4 qt5"
REQUIRED_USE=" ^^ ( gtk qt4 qt5 )"
RESTRICT="strip mirror"

DEPEND=">=dev-lang/lazarus-1.8"
RDEPEND="
	${DEPEND}
	sys-apps/dbus
	dev-libs/glib
	sys-libs/ncurses
	x11-libs/libX11
	gtk? ( x11-libs/gtk+:2 )
	qt4? ( >=dev-qt/qtpascal-2.5 )
	qt5? ( >=dev-qt/qtcore-5.6
		>=dev-qt/qtpascal-2.6 )
"

S="${WORKDIR}/${ABBREV}-${PV}"

src_prepare(){
	 eapply_user

	use gtk && export lcl="gtk2"
	use qt4 && export lcl="qt"
	use qt5 && export lcl="qt5"
	use amd64 && export CPU_TARGET="x86_64" || export CPU_TARGET="i386"

	export lazpath="/usr/share/lazarus"

	if use qt4 ; then
		cp /usr/lib/qt4/libQt4Pas.so plugins/wlx/WlxMplayer/src/
		cp /usr/lib/qt4/libQt4Pas.so src/
	fi

	if use qt5 ; then
		cp /usr/lib/qt4/libQt5Pas.so plugins/wlx/WlxMplayer/src/
		cp /usr/lib/qt4/libQt5Pas.so src/
	fi

	find ./ -type f -name "build.sh" -exec sed -i 's#$lazbuild #$lazbuild --lazarusdir=/usr/share/lazarus #g' {} \;
}

src_compile(){
	./build.sh beta || die
}

src_install(){
	diropts -m0755
	dodir /usr/share

	install/linux/install.sh --portable-prefix=build

	newicon pixmaps/mainicon/colored/v4_3.png ${ABBREV}.png

	rsync -a "${S}/build/" "${D}/usr/share/" || die "Unable to copy files"

	dosym ../share/${ABBREV}/${ABBREV} /usr/bin/${ABBREV}

	make_desktop_entry ${ABBREV} "Double Commander" "${ABBREV}" "Utility;" || die "Failed making desktop entry!"
}

pkg_postinst() {
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
}
