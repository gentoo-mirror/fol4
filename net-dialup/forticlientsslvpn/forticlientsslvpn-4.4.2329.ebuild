# Distributed under the terms of the GNU General Public License v2
# Based on https://aur.archlinux.org/packages/forticlientsslvpn/

EAPI=8
DESCRIPTION="SSL VPN Client for Fortinet"
HOMEPAGE="http://www.forticlient.com/"
SRC_URI="https://github.com/mcereda/forticlientsslvpn/raw/master/tarball/forticlientsslvpn_linux_4.4.2329.tar.gz"
LICENSE="FortiClientSSLVPN"
SLOT="0"
IUSE=""
KEYWORDS="~x86 ~amd64"
DEPEND=""
RDEPEND="${DEPEND}
	sys-apps/net-tools
	x11-libs/libSM
	x11-libs/gtk+:2
	net-dialup/ppp"

S="${WORKDIR}/forticlientsslvpn"
QA_PREBUILT="opt/forticlientsslvpn/32bit/forticlientsslvpn
			 opt/forticlientsslvpn/64bit/forticlientsslvpn
			 opt/forticlientsslvpn/32bit/helper/subproc
			 opt/forticlientsslvpn/64bit/helper/subproc
			 opt/forticlientsslvpn/32bit/helper/showlicense
			 opt/forticlientsslvpn/64bit/helper/printcert
			 opt/forticlientsslvpn/32bit/helper/showlicense
			 opt/forticlientsslvpn/64bit/helper/printcert
			 "


src_unpack() {
	unpack ${A}
	cd "${S}"
}

src_compile() {
	:
}

src_install() {
	exeinto opt/forticlientsslvpn
	doexe fortisslvpn.sh
	exeinto opt/forticlientsslvpn/32bit
	doexe 32bit/forticlientsslvpn
	exeinto opt/forticlientsslvpn/64bit
	doexe 64bit/forticlientsslvpn
	mkdir -vp ${D}/opt/forticlientsslvpn/icons/
	cp -v ${FILESDIR}/forticlientsslvpn.png ${D}/opt/forticlientsslvpn/icons/
	mkdir -p ${D}/usr/share/applications/
	mkdir -p ${D}/usr/bin/
	cp -v ${FILESDIR}/forticlientsslvpn.desktop ${D}/usr/share/applications/
	cp -v ${FILESDIR}/forticlientsslvpn ${D}/usr/bin/
	mkdir -v ${D}/opt/forticlientsslvpn/{32,64}bit
	cp -vr 32bit/helper ${D}/opt/forticlientsslvpn/32bit/
	cp -vr 64bit/helper ${D}/opt/forticlientsslvpn/64bit/
	rm -vr ${D}/opt/forticlientsslvpn/32bit/helper/fctrouternke.kext
	rm -vr ${D}/opt/forticlientsslvpn/64bit/helper/fctrouternke.kext
}

pkg_postinst() {
	ewarn "Forticlient SSL VPN is closed-source."
	einfo "Installed in /opt/forticlientsslvpn"
	einfo ""
	einfo "if your vpn isn't signed from a official CA you have to set"
	einfo "	invalid_peer_cert_action=0"
	einfo "in /opt/forticlientsslvpn/{32,64}bit/helper/config"
}


