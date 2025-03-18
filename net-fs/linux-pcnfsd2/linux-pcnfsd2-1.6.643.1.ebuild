# Copyright 1999-2025 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2

EAPI=8

REALP="linux_pcnfsd2-1.6-643.1"

inherit rpm systemd

DESCRIPTION="Linux PC-NFS daemon"
SRC_URI="http://download.opensuse.org/source/distribution/11.4/repo/oss/suse/src/${REALP}.src.rpm"

SLOT="0"
LICENSE="FSR"
KEYWORDS="~x86 ~sparc ~amd64 ~ppc ~alpha ~ia64 ~mips"
RESTRICT="mirror"

DEPEND="
	net-libs/libtirpc
	virtual/libcrypt:=
"
RDEPEND="${DEPEND}"
S="${WORKDIR}/${PN/-/_}"


# For binary:
src_unpack() {
	rpm_src_unpack
}

src_prepare() {
	eapply -p0 ../linux_pcnfsd2.dif
	eapply "${FILESDIR}/build-with-libtirpc.patch"
	eapply_user
	sed -i s:"CFLAGS = -O2 -fexpensive-optimizations -pipe -DOSVER_BSD386":"CFLAGS = ${CFLAGS} -fpermissive -fexpensive-optimizations -pipe -DOSVER_BSD386 -I/usr/include/tirpc": "${S}/Makefile.linux"
	sed -i s:'LIBS = #-lrpc':'LIBS = -ltirpc': "${S}/Makefile.linux"
}

src_compile() {
	# cd "${WORKDIR}/linux_pcnfsd2/"
	emake -f Makefile.linux || die "Make failed"
}

src_install() {
	mkdir -p "${D}/etc/init.d/"
	cp -p "${FILESDIR}/pcnfsd2.init.d" "${D}/etc/init.d/pcnfsd2"

	cd "${WORKDIR}/linux_pcnfsd2/linux/"
	mkdir -p "${D}/usr/bin/"
	cp -p clnt.pcnfsd rpc.pcnfsd "${D}/usr/bin/"

	doman "${WORKDIR}/linux_pcnfsd2/pcnfsd.8c"
	systemd_newunit "${FILESDIR}"/rpc-pcnfsd.systemd rpc-pcnfsd.service
}
