pkg_name=lld
pkg_origin=core
pkg_version="7.0.1"
pkg_description="LLD is a linker from the LLVM project."
pkg_source="https://releases.llvm.org/${pkg_version}/${pkg_name}-${pkg_version}.src.tar.xz"
pkg_shasum="8869aab2dd2d8e00d69943352d3166d159d7eae2615f66a684f4a0999fc74031"
pkg_upstream_url="https://lld.llvm.org/"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("NCSA")
#llvm_source="https://releases.llvm.org/${pkg_version}/llvm-${pkg_version}.src.tar.xz"
#llvm_shasum="8869aab2dd2d8e00d69943352d3166d159d7eae2615f66a684f4a0999fc74031"
pkg_build_deps=(
  core/clang
  core/cmake
#  core/doxygen
  core/glibc
#  core/libedit
#  core/libxml2
  core/llvm
#  core/ncurses
  core/ninja
  core/pkg-config
  core/python
#  core/swig
)
pkg_deps=(
  core/llvm
  core/gcc-libs
)
pkg_bin_dirs=(bin)

do_prepare() {
  do_default_prepare
  mkdir -p $HAB_CACHE_SRC_PATH/${pkg_name}-${pkg_version}.src/build
#  download_file ${llvm_source} $HAB_CACHE_SRC_PATH/llvm-${pkg_version}.src.tar.xz ${llvm_shasum}
#  cd $HAB_CACHE_SRC_PATH
#  tar -xvf "llvm-${pkg_version}.src.tar.xz"
}
do_build() {
  cd $HAB_CACHE_SRC_PATH/${pkg_name}-${pkg_version}.src/build

#  attach

  cmake .. -G Ninja \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX="$pkg_prefix" \
    -DPYTHON_EXECUTABLE=$(pkg_path_for python)/bin/python \
    -DBUILD_SHARED_LIBS=ON \
    -DLLVM_LINK_LLVM_DYLIB=ON \
    -DLLVM_INCLUDE_TESTS=ON \
    -DLLVM_BUILD_TESTS=ON \
    -DLLVM_MAIN_SRC_DIR=$(pkg_path_for llvm)/src
#    -DLLVM_MAIN_SRC_DIR="$HAB_CACHE_SRC_PATH/llvm-${pkg_version}.src"
#    -DLLVM_PTHREAD_LIBRARY_PATH=$(pkg_path_for llvm)/lib \
#    -DLLVM_ENABLE_SPHINX=ON \
#    -DLLVM_EXTERNAL_LIT=/usr/bin/lit \
  ninja
}

do_install() {
  return 0
}
