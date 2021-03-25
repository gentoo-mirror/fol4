# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
EAPI=7

DESCRIPTION="DTP, and experimental vector graphics tools"
HOMEPAGE="https://laidout.org/"
if [[ ${PV} == 9999* ]] ; then
    inherit git-r3
    EGIT_REPO_URI="https://github.com/Laidout/laidout.git"
else
	SRC_URI="https://github.com/Laidout/laidout/releases/download/${PV}/${P}.tar.bz2"
fi
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
RESTRICT="mirror"

DEPEND="
	dev-libs/openssl
	media-gfx/graphicsmagick
	media-libs/freetype
	media-libs/ftgl
	media-libs/gegl:0.4
	media-libs/harfbuzz
	media-libs/imlib2
	media-libs/lcms
	media-libs/libpng
	net-print/cups
	sys-libs/readline
	sys-libs/zlib
	x11-base/xorg-server
	x11-libs/cairo
"
RDEPEND="${DEPEND}"

DOCS=( AUTHORS COPYING ROADMAP README.md QUICKREF.html features.md )

src_unpack() {
	git-r3_src_unpack
	cd "${S}"
	git-r3_fetch "https://github.com/Laidout/laxkit.git"
	git-r3_checkout "https://github.com/Laidout/laxkit.git" laxkit
	git-r3_fetch "https://github.com/Laidout/laidout-icons.git"
	git-r3_checkout "https://github.com/Laidout/laidout-icons.git" laidout-icons
}

src_prepare() {
	default
	# find . -iname "*Makefile" -print0 | xargs -0 sed -i s:"\`freetype-config --cflags\`":"-I/usr/include/freetype2":g
	# find . -iname "*Makefile" -print0 | xargs -0 sed -i s:"\`freetype-config --libs\`":"-lfreetype":g
	# find . -iname "*Makefile" -print0 | xargs -0 sed -i s:"-L/usr/local/lib":"-L/usr/lib64":g
}

src_configure() {
	cd laxkit
	./configure --disable-sqlite --relocatable --disable-gl --prefix="${D}/usr"
	cd ..
	./configure --prefix="${D}/usr" --relocatable --laxkit=`pwd`/laxkit/lax --nogl --disable-sqlite --gegl-version=gegl-0.4 --version=${PV}
}

src_compile() {
	export CXXFLAGS="${CXXFLAGS} -std=c++11"
	cd laxkit
	emake touchdepends hidegarbage
	cd ..
	emake hidegarbage
	emake
	cp laidout-icons/target-24/* src/icons
}

