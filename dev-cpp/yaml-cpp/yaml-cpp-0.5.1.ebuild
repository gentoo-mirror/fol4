# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit cmake-utils cmake-multilib

DESCRIPTION="A YAML parser and emitter in C++"
HOMEPAGE="http://code.google.com/p/yaml-cpp/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm x86 ~amd64-linux ~x86-linux"
IUSE=""


# app-emulation/emul-linux-x86-cpplibs-20140508 has boost 1.52.0
DEPEND="amd64? (
			!abi_x86_32? ( >=dev-libs/boost-1.49.0-r2 )
			abi_x86_32? ( || (
					( =app-emulation/emul-linux-x86-cpplibs-20140508*[development,-abi_x86_32(-)]
					  =dev-libs/boost-1.52.0*[-abi_x86_32(-)] )
					( >=dev-libs/boost-1.49.0-r2[abi_x86_32(-)] )
				)
			)
		)"

RDEPEND="${DEPEND}"

src_prepare() {
	sed -i \
		-e 's:INCLUDE_INSTALL_ROOT_DIR:INCLUDE_INSTALL_DIR:g' \
		yaml-cpp.pc.cmake || die

	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=ON
	)
	cmake-multilib_src_configure
}
