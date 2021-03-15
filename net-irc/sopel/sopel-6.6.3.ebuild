# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{3_6,3_7,3_8,3_9} pypy3 )

inherit distutils-r1 git-r3 versionator

DESCRIPTION="An easy-to-use and highly extensible IRC Bot framework"
HOMEPAGE="http://sopel.chat/"

# MY_PV="$(delete_version_separator 3)"
# MY_PV="${MY_PV/beta/b}"

EGIT_REPO_URI="https://github.com/sopel-irc/sopel.git"
EGIT_COMMIT="v${PV}"

LICENSE="EFL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""

RDEPEND="dev-python/feedparser[${PYTHON_USEDEP}]
		dev-python/pytz[${PYTHON_USEDEP}]
		dev-python/lxml[${PYTHON_USEDEP}]
		dev-python/pyenchant[${PYTHON_USEDEP}]
		dev-python/geoip2[${PYTHON_USEDEP}]
		<dev-python/praw-6[${PYTHON_USEDEP}]
		dev-python/update-checker[${PYTHON_USEDEP}]
		dev-python/ipython[${PYTHON_USEDEP}]
		dev-python/xmltodict[${PYTHON_USEDEP}]
		<dev-python/dnspython-3[${PYTHON_USEDEP}]
		$(python_gen_cond_dep 'dev-python/backports-ssl-match-hostname[${PYTHON_USEDEP}]' python2_7)"
