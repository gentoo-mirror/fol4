# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
inherit eutils autotools flag-o-matic

DESCRIPTION="Meanwhile (Sametime protocol) library"
HOMEPAGE="http://meanwhile.sourceforge.net/"
SRC_URI="https://github.com/mrcsparker/meanwhile/archive/master.zip -> ${P}.zip"

LICENSE="LGPL-2"
IUSE="doc debug"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sparc x86"

RESTRICT="mirror"

RDEPEND=">=dev-libs/glib-2:2"

S="${WORKDIR}/meanwhile-master"

DEPEND="${RDEPEND}
	dev-libs/gmp
	virtual/pkgconfig
	doc? ( app-doc/doxygen )"

src_prepare() {
	eautoreconf
}

src_configure() {
	strip-flags
	filter-flags -O2 -march=native
	local myconf
	use doc || myconf="${myconf} --enable-doxygen=no"

	econf ${myconf} \
		--disable-static \
		$(use_enable debug)
}

src_install() {
	emake DESTDIR="${D}" install
	find "${D}" -name '*.la' -exec rm -f {} + || die "la file removal failed"
	dodoc AUTHORS ChangeLog NEWS README TODO
}
