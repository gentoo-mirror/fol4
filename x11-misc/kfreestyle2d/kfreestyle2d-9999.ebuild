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
    ebegin "Checking for uinput support"
    local rc=1
    linux_config_exists && linux_chkconfig_present INPUT_UINPUT
    rc=$?

    if [[ ${rc} -ne 0 ]] ; then
        eerror "To use kfreestyle2d, you need to compile your kernel with uinput support."
        eerror "Please enable uinput support in your kernel config, found at:"
        eerror
        eerror "Device Drivers -> Input Device ... -> Miscellaneous devices -> User level driver support."
        eerror
        eerror "Once enabled, you should have the /dev/input/uinput device."
        eerror "kfreestyle2d will not work without the uinput device."
    fi
}

pkg_setup() {
    linux-info_pkg_setup
    uinput_check
}

src_prepare() {
	eapply "${FILESDIR}"/makefile.patch
	eapply_user
}

src_install() {
	mkdir -p "${D}/lib/systemd/system/"
	mkdir -p "${D}/lib/udev/rules.d/"
	default
}
