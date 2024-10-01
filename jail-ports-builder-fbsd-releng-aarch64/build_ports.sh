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
build_port security/doas
build_port editors/hexedit
build_port archivers/unrar
build_port archivers/7-zip
build_port sysutils/smartmontools
build_port net/rsync
build_port ftp/wget
build_port dns/dnsmasq
build_port net/samba416
# build_port net/samba419
build_port net/dhcp6
build_port net/miniupnpd
build_port net/miniupnpc
build_port net/libnatpmp
build_port security/openvpn
build_port net/wireguard-tools
build_port devel/git
build_port net/gitup
build_port www/fcgiwrap
build_port www/nginx
# build_port devel/gdb  # requires boost-libs which requires llvm15
build_port textproc/aspell
build_port textproc/en-aspell
build_port hebrew/aspell
build_port benchmarks/iperf
build_port www/tidy-html5
build_port graphics/p5-Image-ExifTool
build_port audio/flac
build_port audio/lame
build_port textproc/odt2txt
build_port multimedia/ffmpeg

rm -f /var/tmp/*.core || exit 1

pkg_repo_path=$(cd /usr/ports && make -V PACKAGES)
[ -z "$pkg_repo_path" ] && { echo "PACKAGES var is empty" 1>&2; exit 1; }
rm -rf ${pkg_repo_path}/* || exit 1
mkdir ${pkg_repo_path}/All || exit 1
mkdir ${pkg_repo_path}/Latest || exit 1
(cd ${pkg_repo_path}/All && pkg create -a) || exit 1
(cd ${pkg_repo_path}/Latest && ln -sf ../All/pkg-*.pkg pkg.pkg) || exit 1
pkg repo ${pkg_repo_path}
