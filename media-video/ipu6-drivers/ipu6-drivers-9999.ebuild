# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-mod toolchain-funcs

inherit git-r3
# EGIT_REPO_URI="https://git.launchpad.net/~vicamo/+git/intel-ipu6-dkms"
# EGIT_BRANCH="ubuntu/devel"

EGIT_REPO_URI="https://github.com/intel/ipu6-drivers.git"

DESCRIPTION="Drivers for MIPI cameras through the IPU6 on Intel Tiger Lake and Alder Lake platforms."
HOMEPAGE="https://github.com/intel/ipu6-drivers"

SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND="
	virtual/linux-sources
	sys-kernel/linux-headers
	sys-kernel/ivsc-driver
"
RDEPEND=""

MODULE_NAMES="	hm11b1(drivers/media/i2c:${S}:drivers/media/i2c) \
				intel-ipu6(drivers/media/pci/intel/ipu6:${S}:drivers/media/pci/intel/ipu6) \
				intel-ipu6-isys(drivers/media/pci/intel/ipu6:${S}:drivers/media/pci/intel/ipu6) \
				intel-ipu6-psys(drivers/media/pci/intel/ipu6:${S}:drivers/media/pci/intel/ipu6)"

# https://git.launchpad.net/~vicamo/+git/intel-vsc-dkms/tree/debian/patches?h=ubuntu/devel
#PATCHES=(	"${S}/debian/patches/0001-build-disable-ivsc-depending-sensors.patch"
#			"${S}/debian/patches/0003-build-fix-kernel-feature-macro-definitions.patch"
#		)

pkg_setup() {
	linux-mod_pkg_setup

	BUILD_TARGETS="clean all"
	# BUILD_PARAMS="KVERSION=${KV_FULL} CC=$(tc-getCC)"
}

src_compile() {
	KBUILD_MODPOST_WARN=1 linux-mod_src_compile
}

src_install() {
	linux-mod_src_install
}
