# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit multilib-minimal

DESCRIPTION="Modbus library which supports RTU communication over a serial line or a TCP link"
HOMEPAGE="http://libmodbus.org/"
SRC_URI="http://libmodbus.org/releases/${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="static-libs"


src_prepare() {
	multilib_copy_sources
}

multilib_src_configure() {
	econf \
		--disable-silent-rules \
		$(use_enable static-libs static)
}

multilib_src_install() {
	emake install DESTDIR="${D}"
}

multilib_src_install_all() {
	dodoc AUTHORS MIGRATION NEWS README.md
	use static-libs || rm "${D}"/usr/*/libmodbus.la
}
