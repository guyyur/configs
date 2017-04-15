#!/bin/sh

# -- check for root --
if [ "`id -u`" != "0" ]; then
  echo "build_ports.sh: sorry, this must be done as root." 1>&2
  exit 1
fi


# target="config"
# target="config-recursive"
target="install clean"


# -- build ports --
cd /usr/ports/ports-mgmt/pkg && make $target || exit 1
cd /usr/ports/ports-mgmt/portmaster && make $target || exit 1
cd /usr/ports/editors/nano && make $target || exit 1
cd /usr/ports/shells/zsh && make $target || exit 1
cd /usr/ports/sysutils/tmux && make $target || exit 1
cd /usr/ports/local/ddnshupd && make $target || exit 1
cd /usr/ports/net/dhcpcd && make $target || exit 1
cd /usr/ports/dns/dnsmasq && make $target || exit 1
cd /usr/ports/net/mpd5 && make $target || exit 1
cd /usr/ports/net/miniupnpd && make $target || exit 1
cd /usr/ports/security/openvpn && make $target || exit 1
cd /usr/ports/devel/git && make $target || exit 1
cd /usr/ports/www/fcgiwrap && make $target || exit 1
cd /usr/ports/www/nginx && make $target || exit 1
cd /usr/ports/benchmarks/iperf && make $target || exit 1

pkg_repo_path=$(cd /usr/ports && make -V PACKAGES)
[ -z "$pkg_repo_path" ] && { echo "PACKAGES var is empty" 1>&2; exit 1; }
mkdir -p ${pkg_repo_path} || exit 1
mkdir ${pkg_repo_path}/All || exit 1
mkdir ${pkg_repo_path}/Latest || exit 1
(cd ${pkg_repo_path}/All && pkg create -a) || exit 1
(cd ${pkg_repo_path}/Latest && ln -sf ../All/pkg-*.txz pkg.txz) || exit 1
pkg repo ${pkg_repo_path}
