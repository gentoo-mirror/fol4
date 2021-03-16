# Distributed under the terms of the GNU General Public License v2
# Copyright 1999-2015 Gentoo Foundation

EAPI=7
DESCRIPTION="PPD description files and filter for UTAX and Triump-Adler (both based on Kyocera) printers"
HOMEPAGE="http://www.triumph-adler.com/"
SRC_URI="https://www.triumph-adler.de/resource/blob/130194/d317ddb2d4689ba40b3d24a409bf5601/talinuxpackages-ccd-clp-20140115-tar-data.gz -> ${P}.tar.gz"

# I'll admit I'm not quite sure that this license is the correct one, the download page does not mention any license.
# But since this is the Kyocera license, and Triumph-Adler and UTAX printers are based on Kyocera, I assume this is the correct one.
# If you know otherwise, please send a pull request.
LICENSE="kyocera-mita-ppds"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE_L10N="en fr de it pt es"

IUSE=""
for lingua in $IUSE_L10N; do
	IUSE="${IUSE} l10n_$lingua"
done

RDEPEND="net-print/cups
		dev-libs/gmp
		dev-libs/nettle
		dev-libs/libtasn1
		sys-libs/zlib
		net-libs/gnutls"

S="${WORKDIR}/LinuxPackagesTA"

RESTRICT="mirror strip"

src_compile() { :; }

src_install() {
	insinto /usr/share/cups/model/UTAX_TA

	local installall=yes
	for lingua in $IUSE_L10N; do
		if use l10n_$lingua; then
			installall=no
			break;
		fi
	done

	inslanguage() {
		if [[ ${installall} == yes ]] || use l10n_$1; then
			if use x86; then
				doins */32bit/EU/$2/*.ppd || die "failed to install $2 ppds"
				doins */32bit/EU/$2/*.PPD || die "failed to install $2 ppds"
			fi
			if use amd64; then
				doins */64bit/EU/$2/*.ppd || die "failed to install $2 ppds"
				doins */64bit/EU/$2/*.PPD || die "failed to install $2 ppds"
			fi
		fi
	}

	inslanguage en English
	inslanguage fr French
	inslanguage de German
	inslanguage it Italian
	inslanguage pt Portuguese
	inslanguage es Spanish
	
	for ppdfile in "${D}"/usr/share/cups/model/UTAX_TA/*.PPD "${D}"/usr/share/cups/model/UTAX_TA/*.ppd; do
		sed -i s:/usr/lib/cups/filter/kyofilter_B:/usr/libexec/cups/filter/kyofilter_B:g "${ppdfile}"
	done
	
	# There are just two binaries (32bit and 64bit), so it doesn't matter which folder you copy it from
	exeinto /usr/libexec/cups/filter/
	if use x86; then
		doexe "206ci series/32bit/EU/English/kyofilter_B" || die "failed to install cups filter"
	fi
	if use amd64; then
		doexe "206ci series/64bit/EU/English/kyofilter_B" || die "failed to install cups filter"
	fi

}
