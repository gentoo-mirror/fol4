# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit qt5-build versionator

DESCRIPTION="QtWebApi - Qt library for making Web Applications"

HOMEPAGE="http://stefanfrings.de/qtwebapp/index-en.html"
SRC_URI="http://stefanfrings.de/qtwebapp/QtWebApp.zip"

RESTRICT="mirror"

LICENSE="LGPL-3"

S="${WORKDIR}/QtWebApp/QtWebApp"

if [[ ${QT5_BUILD_TYPE} == release ]]; then
	KEYWORDS="~amd64 ~x86"
fi


DEPEND="
	dev-qt/qtcore:5"
RDEPEND="${DEPEND}"

src_prepare() {
	qt5-build_src_prepare
}

src_install() {
	into /usr
	dolib "${WORKDIR}/${PN}-opensource-src-${PV}/libQtWebApp.so.${PV}"

	mkdir -p "${D}/usr/$(get_libdir)"
	cd "${D}/usr/$(get_libdir)"
	ln -s "libQtWebApp.so.${PV}" "libQtWebApp.so.$(get_version_component_range 1-2)"
	ln -s "libQtWebApp.so.${PV}" "libQtWebApp.so.$(get_version_component_range 1)"
	ln -s "libQtWebApp.so.${PV}" "libQtWebApp.so"

	mkdir -p "${D}/usr/include/qt5/QtWebApp/"{httpserver,logging,qtservice,templateengine}
	
	cd "${WORKDIR}/QtWebApp/QtWebApp"
	cp httpserver/*.h "${D}/usr/include/qt5/QtWebApp/httpserver"
	cp logging/*.h "${D}/usr/include/qt5/QtWebApp/logging"
	cp qtservice/*.h "${D}/usr/include/qt5/QtWebApp/qtservice"
	cp templateengine/*.h "${D}/usr/include/qt5/QtWebApp/templateengine"
	
}
