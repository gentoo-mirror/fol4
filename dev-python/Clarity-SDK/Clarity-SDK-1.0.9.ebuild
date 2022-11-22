# Copyright 1999-2022 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7
PYTHON_COMPAT=( python3_{8..11} )

inherit distutils-r1
# DISTUTILS_USE_SETUPTOOLS=rdepend

SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P/-/_}.tar.gz"

DESCRIPTION="Python SDK for the Clarity API"
HOMEPAGE="https://pypi.org/project/Clarity-SDK/"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

S="${WORKDIR}/${P/-/_}"
