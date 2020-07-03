# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=(python3_{6,7,8})
inherit git-r3 python-single-r1 python-utils-r1 eutils desktop

# DESCRIPTION is also Program name in the .desktop file
DESCRIPTION="Control Panel for Microsoft Pro IntelliMouse"
HOMEPAGE="https://github.com/K-Visscher/pro-intellimouse-control-panel/"
EGIT_REPO_URI="https://github.com/madsl/Pro-IntelliMouse-Control-Panel/"
LICENSE="GPL-3"

KEYWORDS="~x86 ~amd64"
SLOT="0"
IUSE=""
RDEPEND="$(python_gen_cond_dep '
	dev-python/PyQt5[${PYTHON_USEDEP}]
	>=dev-python/cython-hidapi-9999[${PYTHON_USEDEP}]')
"
DEPEND="${RDEPEND}"

python_check_deps() {
	has_version "dev-python/PyQt5[${PYTHON_USEDEP}]" \
    && has_version ">=dev-python/cython-hidapi-9999[${PYTHON_USEDEP}]"
}

src_prepare() {
	eapply_user
	# Fix relative path to images
	sed -i s:"'/../resources":"'/resources": "${S}/src/main/python/main.py"
	mv -v "${S}/src/main/python/main.py" "${S}/src/main/python/__main__.py"
	mv -v "${S}/src/main/python/intellimouse.py" "${S}/src/main/python/__init__.py"
}

src_compile() {
	:
}

src_install() {

	python_moduleinto intellimouse
	python_domodule src/main/python/__init__.py src/main/python/__main__.py

	python_domodule src/main/resources

	make_wrapper "${PN}.tmp" "${EPYTHON} -m intellimouse"
	python_newexe "${ED%/}/usr/bin/${PN}.tmp" "${PN}"
	rm "${ED%/}/usr/bin/${PN}.tmp" || die

	newicon -s 128 "${S}/src/main/icons/linux/128.png" intellimouse.png
	newicon -s 256 "${S}/src/main/icons/linux/256.png" intellimouse.png
	newicon -s 512 "${S}/src/main/icons/linux/512.png" intellimouse.png

	make_desktop_entry "${PN}" "${DESCRIPTION}" "intellimouse" "Settings"
}
