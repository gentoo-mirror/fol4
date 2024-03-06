# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="DuckDB embedded database"
SRC_URI="https://github.com/duckdb/duckdb/archive/refs/tags/v${PV}.tar.gz"
HOMEPAGE="https://www.duckdb.org"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

IUSE=""
DEPEND="${RDEPEND}"

RESTRICT="mirror"

src_prepare() {
	# Force setting correct DUCKDB version in CMakeLists.txt, it's a mess
	sed -i /^if\(EMSCRIPTEN\)$/iset\(DUCKDB_VERSION\ v${PV}\) CMakeLists.txt
	cmake_src_prepare
}

src_configure() {

	local mycmakeargs=(
		"-DDUCKDB_DEV_ITERATION=0"
		"-DGIT_COMMIT_HASH=v${PV}"
		"-DDUCKDB_EXTENSION_FOLDER_IS_VERSION=0"
		"-DBUILD_EXTENSIONS='autocomplete;jemalloc;sqlsmith;excel;parquet;icu;tpch;tpcds;fts;json'"
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install
	# Fix libdir (amd64 hardcode here..)
	mv -v "${D}/usr/lib" "${D}/usr/lib64"
}
