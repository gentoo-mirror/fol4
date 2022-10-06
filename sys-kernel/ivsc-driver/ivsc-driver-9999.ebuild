# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-mod toolchain-funcs

inherit git-r3
# EGIT_REPO_URI="https://git.launchpad.net/~vicamo/+git/intel-vsc-dkms"
# EGIT_BRANCH="ubuntu/devel"

EGIT_REPO_URI="https://github.com/intel/ivsc-driver.git"

DESCRIPTION="Driver for Intel Vision Sensing Controller(IVSC) on Intel Alder Lake platforms"
HOMEPAGE="https://github.com/intel/ivsc-driver"

SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND="
	virtual/linux-sources
	sys-kernel/linux-headers
"
RDEPEND=""

# upstream uses folder "updates"
MODULE_NAMES="gpio-ljca(updates) i2c-ljca(updates) intel_vsc(updates) ljca(updates) \
	mei-vsc(updates) mei_ace(updates) mei_ace_debug(updates) mei_csi(updates) mei_pse(updates) \
	spi-ljca(updates)"

# https://git.launchpad.net/~vicamo/+git/intel-vsc-dkms/tree/debian/patches?h=ubuntu/devel
# PATCHES=( "${S}/debian/patches/0002-hm2170-ov01a10-ov01a1s-ov02c10-add-sensor-drivers-fr.patch" )

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
