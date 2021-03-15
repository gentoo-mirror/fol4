# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v3

EAPI=7
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3,3_4,3_5,3_6,3_7,3_8} )
inherit distutils-r1

DESCRIPTION="XBee provides an implementation of the XBee serial communication API."
HOMEPAGE="https://github.com/nioinnovation/python-xbee"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
RESTRICT="mirror"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+tornado"

DEPEND="dev-python/pyserial[${PYTHON_USEDEP}]"
RDEPEND="tornado? ( www-servers/tornado[${PYTHON_USEDEP}] )"



