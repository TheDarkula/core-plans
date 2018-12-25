pkg_name=atk
pkg_origin=core
pkg_version="2.30.0"
pkg_description="Library for a set of interfaces providing accessibility. By supporting the ATK interfaces, an application or toolkit can be used with tools such as screen readers, magnifiers, and alternative input devices."
pkg_upstream_url="https://developer.gnome.org/atk/"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('LGPL-2.0')
pkg_source="https://download.gnome.org/sources/${pkg_name}/${pkg_version%.*}/${pkg_name}-${pkg_version}.tar.xz"
pkg_shasum=dd4d90d4217f2a0c1fee708a555596c2c19d26fef0952e1ead1938ab632c027b
pkg_deps=(
  core/glib
  core/glibc
  core/libffi
  core/libiconv
  core/meson
  core/ninja
  core/pcre
)
pkg_build_deps=(
  core/diffutils
  core/gcc
  core/gettext
  core/make
  core/perl
  core/pkg-config
)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_pconfig_dirs=(lib/pkgconfig)

do_build() {
  attach
  meson _build .
  ninja -C _build dist
}
