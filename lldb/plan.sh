pkg_name=lldb
pkg_origin=core
pkg_version="7.0.1"
pkg_description="LLDB is a next generation, high-performance debugger."
pkg_source="https://releases.llvm.org/${pkg_version}/${pkg_name}-${pkg_version}.src.tar.xz"
pkg_shasum="76b46be75b412a3d22f0d26279306ae7e274fe4d7988a2184c529c38a6a76982"
pkg_upstream_url="https://lldb.llvm.org/"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("NCSA")
pkg_build_deps=(
  core/clang
  core/cmake
  core/doxygen
  core/glibc
  core/libedit
  core/libxml2
  core/llvm
  core/ncurses
  core/ninja
  core/pkg-config
  core/swig
)
pkg_deps=(
  core/llvm
  core/gcc-libs
  core/python2
)
pkg_bin_dirs=(bin)

do_prepare() {
  do_default_prepare
  mkdir -p $HAB_CACHE_SRC_PATH/${pkg_name}-${pkg_version}.src/build
}
do_build() {
  cd $HAB_CACHE_SRC_PATH/${pkg_name}-${pkg_version}.src/build

  cmake .. -G Ninja \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX="$pkg_prefix" \
    -DPYTHON_EXECUTABLE="$(pkg_path_for python2)/bin/python2" \
    -DPYTHON_LIBRARY="$(pkg_path_for python2)/lib/python2.7" \
    -DPYTHON_LIBRARY_DEBUG="$(pkg_path_for python2)/lib/python2.7" \
    -DPYTHON_INCLUDE_DIR="$(pkg_path_for python2)/include/python2.7" \
    -DLIBXML2_LIBRARY="$(pkg_path_for libxml2)/lib" \
    -DLIBXML2_INCLUDE_DIR="$(pkg_path_for libxml2)/include" \
    -DCURSES_LIBRARY="$(pkg_path_for ncurses)/lib" \
    -DCURSES_INCLUDE_PATH="$(pkg_path_for ncurses)/include" \
    -DCURSES_PANEL_LIBRARY="$(pkg_path_for ncurses)/lib" \
    -DCURSES_CURSES_LIBRARY="$(pkg_path_for ncurses)/lib" \
    -DCURSES_FORM_LIBRARY="$(pkg_path_for ncurses)/lib" \
    -DCURSES_NCURSES_LIBRARY="$(pkg_path_for ncurses)/lib" \
    -Dlibedit_LIBRARIES="$(pkg_path_for libedit)/lib" \
    -Dlibedit_INCLUDE_DIRS="$(pkg_path_for libedit)/include" \
    -DBacktrace_INCLUDE_DIR="$(pkg_path_for glibc)/include" \
    -DLLDB_PATH_TO_LLVM_SOURCE="$(pkg_path_for llvm)/include" \
    -DLLVM_LINK_LLVM_DYLIB=ON \
    -DLLDB_USE_SYSTEM_SIX=1
  ninja
}

do_install() {
  return 0
}
