# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..13} )
DISTUTILS_USE_PEP517=setuptools
inherit distutils-r1 git-r3

DESCRIPTION="Provides web-browser based authentication for openconnect to connect to Ivanti/Pulse Secure VPN services"
HOMEPAGE="https://github.com/markus-meier74/openconnect-pulse-gui"

EGIT_BRANCH="master"
EGIT_REPO_URI="https://github.com/markus-meier74/openconnect-pulse-gui.git"
EGIT_COMMIT="v${PV}"

LICENSE="GPL-3"

SLOT="0"
KEYWORDS="~amd64"
#IUSE=""

RDEPEND="
	$(python_gen_cond_dep '
		dev-python/pygobject[${PYTHON_USEDEP}]
	')
	net-libs/webkit-gtk:4.1
	net-vpn/openconnect
"
DEPEND="
	${RDEPEND}
"

DOCS=( "AUTHORS" "LICENSE" "README.md" )

python_install_all() {
	distutils-r1_python_install_all
	
	msg="Sorry, installation of ${PN} failed for some reason... ;_;"
	
	mkdir "sudoers.d/" || die "${msg}"
	echo '%users ALL=(root:root) NOEXEC, NOPASSWD: /usr/bin/openconnect' > "sudoers.d/openconnect" || die "${msg}"
	
	insinto "/usr/share/doc/${PF}/"
	insopts "-m440"
	doins -r "sudoers.d/"
	
	echo 'WEBKIT_DISABLE_DMABUF_RENDERER=1' > "${T}/99${PN}" || die "${msg}"
	doenvd "${T}/99${PN}"
}

pkg_postinst() {
	einfo "${PN} will call sudo to run openconnect."
	einfo "A template sudo configuration file is provided in"
	einfo "'/usr/share/doc/${PF}/sudoers.d/openconnect'."
	einfo "It grants passwordless access to '/usr/bin/openconnect' to all users in group 'users'."
	einfo "Edit it to suit your needs and copy it to '/etc/sudoers.d/openconnect'."
	einfo "sudo requires that this file be owned by root:root"
	einfo "and its permissions be set to 440 (-r--r-----)."
}
