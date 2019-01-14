pkg_name=erlang
pkg_origin=core
pkg_version=21.3
pkg_description="A programming language for massively scalable soft real-time systems."
pkg_upstream_url="http://www.erlang.org/"
pkg_dirname="otp_src_${pkg_version}"
pkg_license=('Apache-2.0')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://github.com/erlang/otp/archive/OTP-${pkg_version}.tar.gz"
pkg_dirname="otp-OTP-${pkg_version}"
pkg_shasum="64a6eea6c1dc2353ad80e29ef57f6ec4192c91478ac2b854d0417b6b2bf4d9bf"
pkg_build_deps=(
  core/autoconf
  core/coreutils
  core/gcc
  core/m4
  core/make
  core/openssl
  core/perl
)
pkg_deps=(
  core/glibc
  core/ncurses
  core/openssl
  core/sed
  core/zlib
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

do_prepare() {
  # The `/bin/pwd` path is hardcoded, so we'll add a symlink if needed.
  if [[ ! -r /bin/pwd ]]; then
    ln -sv "$(pkg_path_for coreutils)/bin/pwd" /bin/pwd
    _clean_pwd=true
  fi

  if [[ ! -r /bin/rm ]]; then
    ln -sv "$(pkg_path_for coreutils)/bin/rm" /bin/rm
    _clean_rm=true
  fi
}

do_build() {
  sed -i 's/std_ssl_locations=.*/std_ssl_locations=""/' erts/configure.in

  ./otp_build autoconf

  ./configure --prefix="${pkg_prefix}" \
              --enable-threads \
              --enable-smp-support \
              --enable-kernel-poll \
              --enable-dynamic-ssl-lib \
              --enable-shared-zlib \
              --enable-hipe \
              --with-ssl="$(pkg_path_for openssl)" \
              --with-ssl-include="$(pkg_path_for openssl)/include" \
              --without-javac
  make
}

do_end() {
  # Clean up the `pwd` link, if we set it up.
  if [[ -n "$_clean_pwd" ]]; then
    rm -fv /bin/pwd
  fi

  if [[ -n "$_clean_rm" ]]; then
    rm -fv /bin/rm
  fi
}
