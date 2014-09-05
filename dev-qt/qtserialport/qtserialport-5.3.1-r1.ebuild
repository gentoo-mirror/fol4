# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit qt4-build-multilib
# inherit qt4-r2 multilib-minimal

DESCRIPTION="QtSerialPort"
SLOT="4"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x64-solaris ~x86-solaris"

IUSE="debug"

DEPEND="dev-qt/qtcore:4[debug=,${MULTILIB_USEDEP}]
	dev-qt/qtgui:4[debug=,${MULTILIB_USEDEP}]"
RDEPEND="${DEPEND}"

MYPATH=${PN}-opensource-src-${PV}

SRC_URI="http://download.qt-project.org/official_releases/qt/5.3/5.3.1/submodules/qtserialport-opensource-src-5.3.1.tar.xz"
S="${WORKDIR}/${MYPATH}"


# QCONFIG_ADD="serialport"
# QCONFIG_DEFINE="QT_SERIALPORT"

qt4-build-multilib_src_prepare() {
	multilib_copy_sources
}

qt4_symlink_tools_to_build_dir() {
	mkdir -p "${BUILD_DIR}"/bin || die

	local bin
	if [ "${ABI}" == "amd64" ]
	then
		for bin in /usr/lib64/qt4/bin/{qmake,moc,rcc,uic}; do
			if [[ -e ${bin} ]]; then
				ln -s "${bin}" "${BUILD_DIR}"/bin/ || die "failed to symlink ${bin}"
			fi
		done
	elif [ "${ABI}" == "x86" ]
	then
		for bin in /usr/lib32/qt4/bin/{qmake,moc,rcc,uic}; do
			if [[ -e ${bin} ]]; then
				ln -s "${bin}" "${BUILD_DIR}"/bin/ || die "failed to symlink ${bin}"
			fi
		done
	fi
}

qt4_multilib_src_configure() {
	qt4_prepare_env
	qt4_symlink_tools_to_build_dir
	# toolchain setup
	tc-export CC CXX OBJCOPY STRIP
	export AR="$(tc-getAR) cqs"
	export LD="$(tc-getCXX)"

	# convert tc-arch to the values supported by Qt
	local arch=
	case $(tc-arch) in
		amd64|x64-*)		  arch=x86_64 ;;
		ppc*-macos)		  arch=ppc ;;
		ppc*)			  arch=powerpc ;;
		sparc*)			  arch=sparc ;;
		x86-macos)		  arch=x86 ;;
		x86*)			  arch=i386 ;;
		alpha|arm|ia64|mips|s390) arch=$(tc-arch) ;;
		hppa|sh)		  arch=generic ;;
		*) die "qt4-build-multilib.eclass: unsupported tc-arch '$(tc-arch)'" ;;
	esac

	[ "${ABI}" == "amd64" ] && "${BUILD_DIR}/bin/qmake" -spec linux-g++ "${BUILD_DIR}/${PN}.pro"
	[ "${ABI}" == "x86" ] && "${BUILD_DIR}/bin/qmake" -spec linux-g++-32 "${BUILD_DIR}/${PN}.pro"
}

qt4_multilib_src_compile() {
	qt4_prepare_env
	
	emake
}

qt4_multilib_src_install() {
	qt4_prepare_env

	emake INSTALL_ROOT="${D}" install
}
