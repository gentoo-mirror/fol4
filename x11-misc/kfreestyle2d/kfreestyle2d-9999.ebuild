# Copyright 2022 Mads
# Distributed under the terms of the GNU General Public License v2

EAPI=7
DESCRIPTION="Unofficial Kinesis Freestyle 2 Userspace Linux Driver"
HOMEPAGE="https://github.com/whereswaldon/kfreestyle2d"

inherit linux-info git-r3
EGIT_REPO_URI="https://github.com/whereswaldon/kfreestyle2d.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"

DEPEND="acct-group/input"

uinput_check() {
    ebegin "Checking for uinput and hidraw support"
    local rc=1
    linux_config_exists && linux_chkconfig_present INPUT_UINPUT HIDRAW
    rc=$?

    if [[ ${rc} -ne 0 ]] ; then
        eerror "To use kfreestyle2d, you need to compile your kernel with uinput and hidraw support."
        eerror "Please enable uinput and hidraw support in your kernel config."
    fi
}

pkg_setup() {
    linux-info_pkg_setup
    uinput_check
}

src_prepare() {
	eapply "${FILESDIR}"/makefile.patch
	eapply "${FILESDIR}"/kfreestyle2d.service.patch
	eapply_user
}

src_install() {
	mkdir -v -p "${D}/lib/systemd/system"
	mkdir -v -p "${D}/lib/udev/rules.d"
	mkdir -v -p "${D}/etc/modules-load.d"
	cp -v "${FILESDIR}/uinput.conf" "${D}/etc/modules-load.d/"
	default
}
