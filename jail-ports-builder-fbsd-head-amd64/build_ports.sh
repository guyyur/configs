#!/bin/sh

# -- check for root --
if [ "$(id -u)" != "0" ]; then
  echo "build_ports.sh: sorry, this must be done as root." 1>&2
  exit 1
fi


# target="config-conditional"
# target="config-recursive"
target="install clean"


build_port()
{
  cd /usr/ports/"$1" && make $target || exit 1
}

install_package()
{
  pkg install --repository FreeBSD -y "$1" || exit 1
}


# -- build ports --
build_port ports-mgmt/pkg
build_port ports-mgmt/portmaster
build_port security/ca_root_nss
build_port editors/nano
build_port shells/zsh
build_port ftp/curl
build_port lang/python3
build_port devel/ncurses
build_port misc/terminfo-db
build_port sysutils/tmux
build_port net/dhcpcd
build_port devel/git
# build_port devel/gdb
build_port benchmarks/iperf
build_port sysutils/u-boot-rock64
build_port emulators/qemu-user-static

rm -f /var/tmp/*.core || exit 1

pkg_repo_path=$(cd /usr/ports && make -V PACKAGES)
[ -z "$pkg_repo_path" ] && { echo "PACKAGES var is empty" 1>&2; exit 1; }
rm -rf ${pkg_repo_path}/* || exit 1
mkdir ${pkg_repo_path}/All || exit 1
mkdir ${pkg_repo_path}/Latest || exit 1
(cd ${pkg_repo_path}/All && pkg create -a) || exit 1
(cd ${pkg_repo_path}/Latest && ln -sf ../All/pkg-*.pkg pkg.pkg) || exit 1
pkg repo ${pkg_repo_path}
