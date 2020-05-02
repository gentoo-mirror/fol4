# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit qmake-utils

DESCRIPTION="selective bind Qt to free pascal"
HOMEPAGE="http://users.telenet.be/Jan.Van.hijfte/qtforfpc/fpcqt4.html"
FULL_VERSION="qt5pas-V${PV}Alpha_Qt5.1.1"
SRC_URI="
!bindist? ( http://users.telenet.be/Jan.Van.hijfte/qtforfpc/V${PV}/splitbuild-${FULL_VERSION}.tar.gz )
bindist? ( http://users.telenet.be/Jan.Van.hijfte/qtforfpc/V${PV}/bin-${FULL_VERSION}.tar.gz )
"
LICENSE="GPL-2"
SLOT="5"

KEYWORDS="~x86 ~amd64"
IUSE="-bindist"

DEPEND="
	dev-qt/qtcore:5
	dev-qt/qtwebkit:5
	dev-qt/qtgui:5
"
QA_PREBUILT="bindist? ( */libQt5Pas.so.1.2.6 )"

src_unpack(){
	local archive="${FULL_VERSION}"
	if use bindist; then
			archive="bin64-${FULL_VERSION}"
		else
			archive="splitbuild-${FULL_VERSION}"
	fi
	unpack ${archive}.tar.gz

	cd "${WORKDIR}"
	mv "${archive}" "${PF}"
}

src_prepare(){
	eapply_user

	if ! use bindist; then
		eqmake4 Qt45as.pro
	fi
}

#src_install(){
#	dolib libQt4Pas*
#}

