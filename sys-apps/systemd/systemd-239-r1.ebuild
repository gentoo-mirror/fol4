# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

if [[ ${PV} == 9999 ]]; then
	EGIT_REPO_URI="https://github.com/systemd/systemd.git"
	inherit git-r3
else
	SRC_URI="https://github.com/systemd/systemd/archive/v${PV}/${P}.tar.gz
		https://dev.gentoo.org/~floppym/dist/${P}-patches-0.tar.gz"
	KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
fi

PYTHON_COMPAT=( python{3_8,3_9,3_10} )

inherit bash-completion-r1 linux-info meson multilib-minimal ninja-utils pam python-any-r1 systemd toolchain-funcs udev

DESCRIPTION="System and service manager for Linux"
HOMEPAGE="https://www.freedesktop.org/wiki/Software/systemd"

LICENSE="GPL-2 LGPL-2.1 MIT public-domain"
SLOT="0/2"
IUSE="acl apparmor audit build cryptsetup curl elfutils +gcrypt gnuefi http idn importd +kmod libidn2 +lz4 lzma nat pam pcre policykit qrcode +seccomp +split-usr ssl +sysv-utils test vanilla xkb"

REQUIRED_USE="importd? ( curl gcrypt lzma )"
RESTRICT="!test? ( test )"

MINKV="3.11"

COMMON_DEPEND=">=sys-apps/util-linux-2.30:0=[${MULTILIB_USEDEP}]
	sys-libs/libcap:0=[${MULTILIB_USEDEP}]
	!<sys-libs/glibc-2.16
	acl? ( sys-apps/acl:0= )
	apparmor? ( sys-libs/libapparmor:0= )
	audit? ( >=sys-process/audit-2:0= )
	cryptsetup? ( >=sys-fs/cryptsetup-1.6:0= )
	curl? ( net-misc/curl:0= )
	elfutils? ( >=dev-libs/elfutils-0.158:0= )
	gcrypt? ( >=dev-libs/libgcrypt-1.4.5:0=[${MULTILIB_USEDEP}] )
	http? (
		>=net-libs/libmicrohttpd-0.9.33:0=
		ssl? ( >=net-libs/gnutls-3.1.4:0= )
	)
	idn? (
		libidn2? ( net-dns/libidn2:= )
		!libidn2? ( net-dns/libidn:= )
	)
	importd? (
		app-arch/bzip2:0=
		sys-libs/zlib:0=
	)
	kmod? ( >=sys-apps/kmod-15:0= )
	lz4? ( >=app-arch/lz4-0_p131:0=[${MULTILIB_USEDEP}] )
	lzma? ( >=app-arch/xz-utils-5.0.5-r1:0=[${MULTILIB_USEDEP}] )
	nat? ( net-firewall/iptables:0= )
	pam? ( virtual/pam:=[${MULTILIB_USEDEP}] )
	pcre? ( dev-libs/libpcre2 )
	qrcode? ( media-gfx/qrencode:0= )
	seccomp? ( >=sys-libs/libseccomp-2.3.3:0= )
	xkb? ( >=x11-libs/libxkbcommon-0.4.1:0= )"

# baselayout-2.2 has /run
RDEPEND="${COMMON_DEPEND}
	>=sys-apps/baselayout-2.2
	sysv-utils? ( !sys-apps/sysvinit )
	!sysv-utils? ( sys-apps/sysvinit )
	!build? ( || (
		sys-apps/util-linux[kill(-)]
		sys-process/procps[kill(+)]
		sys-apps/coreutils[kill(-)]
	) )
	!<sys-kernel/dracut-044
	!sys-fs/eudev
	!sys-fs/udev"

# sys-apps/dbus: the daemon only (+ build-time lib dep for tests)
PDEPEND=">=sys-apps/dbus-1.9.8[systemd]
	>=sys-apps/hwids-20150417[udev]
	>=sys-fs/udev-init-scripts-25
	policykit? ( sys-auth/polkit )
	!vanilla? ( sys-apps/gentoo-systemd-integration )"

# Newer linux-headers needed by ia64, bug #480218
DEPEND="${COMMON_DEPEND}
	app-arch/xz-utils:0
	dev-util/gperf
	>=dev-util/intltool-0.50
	>=sys-apps/coreutils-8.16
	>=sys-kernel/linux-headers-${MINKV}
	virtual/pkgconfig
	gnuefi? ( >=sys-boot/gnu-efi-3.0.2 )
	test? ( sys-apps/dbus )
	app-text/docbook-xml-dtd:4.2
	app-text/docbook-xml-dtd:4.5
	app-text/docbook-xsl-stylesheets
	dev-libs/libxslt:0
	$(python_gen_any_dep 'dev-python/lxml[${PYTHON_USEDEP}]')
"

pkg_pretend() {
	if [[ ${MERGE_TYPE} != buildonly ]]; then
		local CONFIG_CHECK="~AUTOFS4_FS ~BLK_DEV_BSG ~CGROUPS
			~CHECKPOINT_RESTORE ~DEVTMPFS ~EPOLL ~FANOTIFY ~FHANDLE
			~INOTIFY_USER ~IPV6 ~NET ~NET_NS ~PROC_FS ~SIGNALFD ~SYSFS
			~TIMERFD ~TMPFS_XATTR ~UNIX
			~CRYPTO_HMAC ~CRYPTO_SHA256 ~CRYPTO_USER_API_HASH
			~!FW_LOADER_USER_HELPER_FALLBACK ~!GRKERNSEC_PROC ~!IDE ~!SYSFS_DEPRECATED
			~!SYSFS_DEPRECATED_V2"

		use acl && CONFIG_CHECK+=" ~TMPFS_POSIX_ACL"
		use seccomp && CONFIG_CHECK+=" ~SECCOMP ~SECCOMP_FILTER"
		kernel_is -lt 3 7 && CONFIG_CHECK+=" ~HOTPLUG"
		kernel_is -lt 4 7 && CONFIG_CHECK+=" ~DEVPTS_MULTIPLE_INSTANCES"
		kernel_is -ge 4 10 && CONFIG_CHECK+=" ~CGROUP_BPF"

		if linux_config_exists; then
			local uevent_helper_path=$(linux_chkconfig_string UEVENT_HELPER_PATH)
			if [[ -n ${uevent_helper_path} ]] && [[ ${uevent_helper_path} != '""' ]]; then
				ewarn "It's recommended to set an empty value to the following kernel config option:"
				ewarn "CONFIG_UEVENT_HELPER_PATH=${uevent_helper_path}"
			fi
			if linux_chkconfig_present X86; then
				CONFIG_CHECK+=" ~DMIID"
			fi
		fi

		if kernel_is -lt ${MINKV//./ }; then
			ewarn "Kernel version at least ${MINKV} required"
		fi

		check_extra_config
	fi
}

pkg_setup() {
	case ${CHOST} in
		*-musl*) ;;
		*) die "This systemd ebuild requires a musl libc" ;;
	esac

}

src_unpack() {
	default
	[[ ${PV} != 9999 ]] || git-r3_src_unpack
}

src_prepare() {
	# Do NOT add patches here
	local PATCHES=()

	[[ -d "${WORKDIR}"/patches ]] && PATCHES+=( "${WORKDIR}"/patches )

	# Add local patches here
	PATCHES+=(
		"${FILESDIR}"/239-debug-extra.patch
	)

	if ! use vanilla; then
		PATCHES+=(
			"${FILESDIR}/gentoo-Dont-enable-audit-by-default.patch"
			"${FILESDIR}/gentoo-systemd-user-pam.patch"
			"${FILESDIR}/gentoo-uucp-group-r1.patch"
			"${FILESDIR}/gentoo-generator-path.patch"
			"${FILESDIR}/0001-binfmt-Don-t-install-dependency-links-at-install-tim.patch"
			"${FILESDIR}/0001-Fix-to-run-efi_cc-and-efi_ld-correctly-when-cross-co.patch"
			"${FILESDIR}/0001-login-use-parse_uid-when-unmounting-user-runtime-dir.patch"
			"${FILESDIR}/0001-Remove-fstack-protector-flags-to-workaround-musl-bui.patch"
			"${FILESDIR}/0001-sd-bus-make-BUS_DEFAULT_TIMEOUT-configurable.patch"
			"${FILESDIR}/0001-Use-getenv-when-secure-versions-are-not-available.patch"
			"${FILESDIR}/0002-don-t-use-glibc-specific-qsort_r.patch"
			"${FILESDIR}/0003-comparison_fn_t-is-glibc-specific-use-raw-signature-.patch"
			"${FILESDIR}/0003-implment-systemd-sysv-install-for-OE.patch"
			"${FILESDIR}/0004-add-fallback-parse_printf_format-implementation.patch"
			"${FILESDIR}/0004-rules-whitelist-hd-devices.patch"
			"${FILESDIR}/0005-include-gshadow-only-if-ENABLE_GSHADOW-is-1.patch"
			"${FILESDIR}/0005-Make-root-s-home-directory-configurable.patch"
			"${FILESDIR}/0006-remove-nobody-user-group-checking.patch"
			"${FILESDIR}/0006-src-basic-missing.h-check-for-missing-strndupa.patch"
			"${FILESDIR}/0007-Include-netinet-if_ether.h.patch"
			"${FILESDIR}/0007-rules-watch-metadata-changes-in-ide-devices.patch"
			"${FILESDIR}/0008-Do-not-enable-nss-tests-if-nss-systemd-is-not-enable.patch"
			"${FILESDIR}/0008-don-t-fail-if-GLOB_BRACE-and-GLOB_ALTDIRFUNC-is-not-.patch"
			"${FILESDIR}/0009-add-missing-FTW_-macros-for-musl.patch"
			"${FILESDIR}/0009-nss-mymachines-Build-conditionally-when-ENABLE_MYHOS.patch"
			"${FILESDIR}/0010-socket-util-don-t-fail-if-libc-doesn-t-support-IDN.patch"
			"${FILESDIR}/0011-src-basic-missing.h-check-for-missing-__compar_fn_t-.patch"
			"${FILESDIR}/0012-fix-missing-of-__register_atfork-for-non-glibc-build.patch"
			"${FILESDIR}/0013-Use-uintmax_t-for-handling-rlim_t.patch"
			"${FILESDIR}/0014-fix-missing-ULONG_LONG_MAX-definition-in-case-of-mus.patch"
			"${FILESDIR}/0015-test-hexdecoct.c-Include-missing.h-for-strndupa.patch"
			"${FILESDIR}/0016-test-sizeof.c-Disable-tests-for-missing-typedefs-in-.patch"
			"${FILESDIR}/0017-don-t-pass-AT_SYMLINK_NOFOLLOW-flag-to-faccessat.patch"
			"${FILESDIR}/0018-Define-glibc-compatible-basename-for-non-glibc-syste.patch"
			"${FILESDIR}/0019-Do-not-disable-buffering-when-writing-to-oom_score_a.patch"
			"${FILESDIR}/0020-distinguish-XSI-compliant-strerror_r-from-GNU-specif.patch"
			"${FILESDIR}/0021-Hide-__start_BUS_ERROR_MAP-and-__stop_BUS_ERROR_MAP.patch"
			"${FILESDIR}/0022-build-sys-Detect-whether-struct-statx-is-defined-in-.patch"
		)
	fi

	default
}

src_configure() {
	# Prevent conflicts with i686 cross toolchain, bug 559726
	tc-export AR CC NM OBJCOPY RANLIB

	python_setup

	multilib-minimal_src_configure
}

meson_use() {
	usex "$1" true false
}

meson_multilib() {
	if multilib_is_native_abi; then
		echo true
	else
		echo false
	fi
}

meson_multilib_native_use() {
	if multilib_is_native_abi && use "$1"; then
		echo true
	else
		echo false
	fi
}

multilib_src_configure() {
	local myconf=(
		--localstatedir="${EPREFIX}/var"
		-Dpamlibdir="$(getpam_mod_dir)"
		# avoid bash-completion dep
		-Dbashcompletiondir="$(get_bashcompdir)"
		# make sure we get /bin:/sbin in PATH
		-Dsplit-usr=$(usex split-usr true false)
		-Drootprefix="$(usex split-usr "${EPREFIX:-/}" "${EPREFIX}/usr")"
		-Dsysvinit-path=
		-Dsysvrcnd-path=
		# Avoid infinite exec recursion, bug 642724
		-Dtelinit-path="${EPREFIX}/lib/sysvinit/telinit"
		# no deps
		-Defi=$(meson_multilib)
		-Dima=true
		# Optional components/dependencies
		-Dacl=$(meson_multilib_native_use acl)
		-Dapparmor=$(meson_multilib_native_use apparmor)
		-Daudit=$(meson_multilib_native_use audit)
		-Dlibcryptsetup=$(meson_multilib_native_use cryptsetup)
		-Dlibcurl=$(meson_multilib_native_use curl)
		-Delfutils=$(meson_multilib_native_use elfutils)
		-Dgcrypt=$(meson_use gcrypt)
		-Dgnu-efi=$(meson_multilib_native_use gnuefi)
		-Defi-libdir="${EPREFIX}/usr/$(get_libdir)"
		-Dmicrohttpd=$(meson_multilib_native_use http)
		$(usex http -Dgnutls=$(meson_multilib_native_use ssl) -Dgnutls=false)
		-Dimportd=$(meson_multilib_native_use importd)
		-Dnss-systemd=false
		-Dbzip2=$(meson_multilib_native_use importd)
		-Dzlib=$(meson_multilib_native_use importd)
		-Dkmod=$(meson_multilib_native_use kmod)
		-Dlz4=$(meson_use lz4)
		-Dxz=$(meson_use lzma)
		-Dlibiptc=$(meson_multilib_native_use nat)
		-Dpam=$(meson_use pam)
		-Dpcre2=$(meson_multilib_native_use pcre)
		-Dpolkit=$(meson_multilib_native_use policykit)
		-Dqrencode=$(meson_multilib_native_use qrcode)
		-Dseccomp=$(meson_multilib_native_use seccomp)
		-Dselinux=false
		-Dsmack=false
		-Dportabled=false
		#-Dtests=$(meson_multilib_native_use test)
		-Ddbus=$(meson_multilib_native_use test)
		-Dxkbcommon=$(meson_multilib_native_use xkb)
		# hardcode a few paths to spare some deps
		-Dkill-path=/bin/kill
		-Dntp-servers="0.gentoo.pool.ntp.org 1.gentoo.pool.ntp.org 2.gentoo.pool.ntp.org 3.gentoo.pool.ntp.org"
		# Breaks screen, tmux, etc.
		-Ddefault-kill-user-processes=false

		# multilib options
		-Dbacklight=$(meson_multilib)
		-Dbinfmt=$(meson_multilib)
		-Dcoredump=$(meson_multilib)
		-Denvironment-d=$(meson_multilib)
		-Dfirstboot=$(meson_multilib)
		-Dhibernate=$(meson_multilib)
		-Dhostnamed=false
		-Dhwdb=$(meson_multilib)
		-Dldconfig=$(meson_multilib)
		-Dlocaled=false
		-Dgshadow=false
		-Dmyhostname=false
		-Dmymachines=false
		-Dresolve=false
		-Dman=$(meson_multilib)
		-Dnetworkd=$(meson_multilib)
		-Dquotacheck=$(meson_multilib)
		-Drandomseed=$(meson_multilib)
		-Drfkill=$(meson_multilib)
		-Dsysusers=false
		-Dutmp=false
		-Dtimedated=$(meson_multilib)
		-Dtimesyncd=$(meson_multilib)
		-Dtmpfiles=$(meson_multilib)
		-Dvconsole=$(meson_multilib)
	)

	if multilib_is_native_abi && use idn; then
		myconf+=(
			-Dlibidn2=$(usex libidn2 true false)
			-Dlibidn=$(usex libidn2 false true)
		)
	else
		myconf+=(
			-Dlibidn2=false
			-Dlibidn=false
		)
	fi

	meson_src_configure "${myconf[@]}"
}

multilib_src_compile() {
	eninja
}

multilib_src_test() {
	unset DBUS_SESSION_BUS_ADDRESS XDG_RUNTIME_DIR
	eninja test
}

multilib_src_install() {
	DESTDIR="${D}" eninja install
}

multilib_src_install_all() {
	local rootprefix=$(usex split-usr '' /usr)

	# meson doesn't know about docdir
	mv "${ED%/}"/usr/share/doc/{systemd,${PF}} || die

	einstalldocs

	if ! use sysv-utils; then
		rm "${ED%/}${rootprefix}"/sbin/{halt,init,poweroff,reboot,runlevel,shutdown,telinit} || die
		rm "${ED%/}"/usr/share/man/man1/init.1 || die
		rm "${ED%/}"/usr/share/man/man8/{halt,poweroff,reboot,runlevel,shutdown,telinit}.8 || die
	fi

	if ! use sysv-utils; then
		rmdir "${ED%/}${rootprefix}"/sbin || die
	fi

	# Preserve empty dirs in /etc & /var, bug #437008
	keepdir /etc/{binfmt.d,modules-load.d,tmpfiles.d}
	keepdir /etc/systemd/{ntp-units.d,user} /var/lib/systemd
	keepdir /etc/udev/{hwdb.d,rules.d}
	keepdir /var/log/journal/remote

	# Symlink /etc/sysctl.conf for easy migration.
	dosym ../sysctl.conf /etc/sysctl.d/99-sysctl.conf

	# If we install these symlinks, there is no way for the sysadmin to remove them
	# permanently.
	rm -f "${ED%/}"/etc/systemd/system/multi-user.target.wants/systemd-networkd.service || die
	rm -f "${ED%/}"/etc/systemd/system/dbus-org.freedesktop.network1.service || die
	rm -fr "${ED%/}"/etc/systemd/system/network-online.target.wants || die
	rm -fr "${ED%/}"/etc/systemd/system/sockets.target.wants || die
	rm -fr "${ED%/}"/etc/systemd/system/sysinit.target.wants || die

	local udevdir=/lib/udev
	use split-usr || udevdir=/usr/lib/udev

	rm -r "${ED%/}${udevdir}/hwdb.d" || die

	if use split-usr; then
		# Avoid breaking boot/reboot
		dosym ../../../lib/systemd/systemd /usr/lib/systemd/systemd
		dosym ../../../lib/systemd/systemd-shutdown /usr/lib/systemd/systemd-shutdown
	fi
}

migrate_locale() {
	local envd_locale_def="${EROOT%/}/etc/env.d/02locale"
	local envd_locale=( "${EROOT%/}"/etc/env.d/??locale )
	local locale_conf="${EROOT%/}/etc/locale.conf"

	if [[ ! -L ${locale_conf} && ! -e ${locale_conf} ]]; then
		# If locale.conf does not exist...
		if [[ -e ${envd_locale} ]]; then
			# ...either copy env.d/??locale if there's one
			ebegin "Moving ${envd_locale} to ${locale_conf}"
			mv "${envd_locale}" "${locale_conf}"
			eend ${?} || FAIL=1
		else
			# ...or create a dummy default
			ebegin "Creating ${locale_conf}"
			cat > "${locale_conf}" <<-EOF
				# This file has been created by the sys-apps/systemd ebuild.
				# See locale.conf(5) and localectl(1).

				# LANG=${LANG}
			EOF
			eend ${?} || FAIL=1
		fi
	fi

	if [[ ! -L ${envd_locale} ]]; then
		# now, if env.d/??locale is not a symlink (to locale.conf)...
		if [[ -e ${envd_locale} ]]; then
			# ...warn the user that he has duplicate locale settings
			ewarn
			ewarn "To ensure consistent behavior, you should replace ${envd_locale}"
			ewarn "with a symlink to ${locale_conf}. Please migrate your settings"
			ewarn "and create the symlink with the following command:"
			ewarn "ln -s -n -f ../locale.conf ${envd_locale}"
			ewarn
		else
			# ...or just create the symlink if there's nothing here
			ebegin "Creating ${envd_locale_def} -> ../locale.conf symlink"
			ln -n -s ../locale.conf "${envd_locale_def}"
			eend ${?} || FAIL=1
		fi
	fi
}

pkg_postinst() {
	newusergroup() {
		enewgroup "$1"
		enewuser "$1" -1 -1 -1 "$1"
	}

	enewgroup input
	enewgroup kvm 78
	enewgroup render
	enewgroup systemd-journal
	newusergroup systemd-bus-proxy
	newusergroup systemd-coredump
	newusergroup systemd-journal-gateway
	newusergroup systemd-journal-remote
	newusergroup systemd-journal-upload
	newusergroup systemd-network
	newusergroup systemd-timesync

	systemd_update_catalog

	# Keep this here in case the database format changes so it gets updated
	# when required. Despite that this file is owned by sys-apps/hwids.
	if has_version "sys-apps/hwids[udev]"; then
		udevadm hwdb --update --root="${EROOT%/}"
	fi

	udev_reload || FAIL=1

	# Bug 465468, make sure locales are respect, and ensure consistency
	# between OpenRC & systemd
	migrate_locale

	systemd_reenable systemd-networkd.service

	if [[ ${FAIL} ]]; then
		eerror "One of the postinst commands failed. Please check the postinst output"
		eerror "for errors. You may need to clean up your system and/or try installing"
		eerror "systemd again."
		eerror
	fi
}

pkg_prerm() {
	# If removing systemd completely, remove the catalog database.
	if [[ ! ${REPLACED_BY_VERSION} ]]; then
		rm -f -v "${EROOT}"/var/lib/systemd/catalog/database
	fi
}
