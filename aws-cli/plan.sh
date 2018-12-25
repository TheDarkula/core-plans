pkg_name=aws-cli
pkg_origin=core
pkg_version="1.16.81"
pkg_source="https://github.com/aws/${pkg_name}/archive/${pkg_version}.tar.gz"
pkg_shasum="7ce2fe9ca4c04bff7d8f8685f0ae367deb3a31996a530e635d3460cd5169afe0"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_upstream_url=https://aws.amazon.com/cli/
pkg_license=('Apache-2.0')
pkg_description="The AWS Command Line Interface (CLI) is a unified tool to \
  manage your AWS services. With just one tool to download and configure, you \
  can control multiple AWS services from the command line and automate them \
  through scripts."
pkg_build_deps=(
  core/gawk
  core/sed
)
pkg_deps=(
  core/groff
  core/python
)
pkg_lib_dirs=(lib)
pkg_bin_dirs=(bin)


do_build() {
  python setup.py build
}

#  interpreter_old="/usr/bin/env"
#  interpreter_new="$(pkg_path_for coreutils)/bin/env"
#
#  grep -nrlI '\#\!/usr/bin/env' "$GOPATH/src/code.gitea.io" | while read -r filesToFix; do
#    sed -e "s#\#\!${interpreter_old}#\#\!${interpreter_new}#" -i "$filesToFix"
#  done

do_install() {
  python setup.py install --root="$pkg_prefix" --optimize=1
  mv $pkg_prefix/$(pkg_path_for python)/bin/* $pkg_prefix/bin/
  mv $pkg_prefix/$(pkg_path_for python)/lib/* $pkg_prefix/lib/
  attach
}

