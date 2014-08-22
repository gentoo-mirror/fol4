# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
inherit eutils autotools git-2

# MY_P="${P/_/-}"
# S="${WORKDIR}/${MY_P}"
DESCRIPTION="Audacious Player - Your music, your way, no exceptions"
HOMEPAGE="http://audacious-media-player.org/"
EGIT_REPO_URI="git://github.com/audacious-media-player/audacious.git"

SRC_URI="mirror://gentoo/gentoo_ice-xmms-0.2.tar.bz2"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux"

IUSE="chardet nls qt5"

RDEPEND=">=dev-libs/dbus-glib-0.60
	>=dev-libs/glib-2.28
	dev-libs/libxml2
	>=x11-libs/cairo-1.2.6
	>=x11-libs/pango-1.8.0
	>=x11-libs/gtk+-2.24:2
	qt5? (
		dev-qt/qtcore:5
		dev-qt/qtgui:5
		dev-qt/qtwidgets:5
	)"

DEPEND="${RDEPEND}
	virtual/pkgconfig
	chardet? ( >=app-i18n/libguess-1.2 )
	nls? ( dev-util/intltool )"

PDEPEND="~media-plugins/audacious-plugins-9999"


src_prepare() {
	# sed -i s/Qt5Widgets//g ${S}/acinclude.m4
	# sed -i s/Qt5/Qt/g ${S}/acinclude.m4
	# for f in $( grep -lr '<QtWidgets>' ${S}/* ); do sed -i s/'#include <QtWidgets>'/'#include <QtGui>\n#if QT_VERSION >= 0x050000\n\t#include <QtWidgets>\n#endif'/g ${f}; done
	eautoreconf
}

src_configure() {
	# D-Bus is a mandatory dependency, remote control,
	# session management and some plugins depend on this.
	# Building without D-Bus is *unsupported* and a USE-flag
	# will not be added due to the bug reports that will result.
	# Bugs #197894, #199069, #207330, #208606
	econf \
		--enable-dbus \
		$(use_enable chardet) \
		$(use_enable nls) \
		$(use_enable qt5 qt)
}

src_install() {
	default
	dodoc AUTHORS

	# Gentoo_ice skin installation; bug #109772
	insinto /usr/share/audacious/Skins/gentoo_ice
	doins "${WORKDIR}"/gentoo_ice/*
	docinto gentoo_ice
	dodoc "${WORKDIR}"/README
}
