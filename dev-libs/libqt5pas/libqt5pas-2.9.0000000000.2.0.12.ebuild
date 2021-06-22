# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit qmake-utils

DESCRIPTION="selective bind Qt to free pascal"
HOMEPAGE="http://users.telenet.be/Jan.Van.hijfte/qtforfpc/fpcqt4.html"

#Latest version of  qtpascal is included into lazarus distribution
#So, we need to download lazarus sources and exteract  qtpascal
#To indicate which lazarus version is used to extract the qtpascal sources,
#we use the following version notation: qtpascal_version.0000000000.lazarus_version,
#for example 2.6.0000000000.2.0.2 means that qtpascal version is 2.6, and sources
#are extracted from lazarus 2.0.2
#ten zeros is the separator
export regex="0000000000.(.*)"
if [[ ${PV} =~ $regex ]]; then  export lazarus_version=${BASH_REMATCH[1]};fi

SRC_URI="https://sourceforge.net/projects/lazarus/files/Lazarus%20Zip%20_%20GZip/Lazarus%20${lazarus_version}/lazarus-${lazarus_version}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64" 

#where one can find sources for qtpascal
S="${WORKDIR}/lazarus/lcl/interfaces/qt5/cbindings"
DEPEND="
	dev-qt/qtcore:5
	dev-qt/qtx11extras:5
	dev-qt/qtgui:5
	dev-qt/qtprintsupport:5
"

src_configure(){
	local myqmakeargs=(
		QMAKE_CXXFLAGS="${CXXFLAGS} -I/usr/include/qt5/QtPrintSupport"
	)
	
	cd $S && eqmake5 "${myqmakeargs[@]}"
}

src_compile(){
	:
}
src_install(){
emake INSTALL_ROOT="${D}" install 
}
