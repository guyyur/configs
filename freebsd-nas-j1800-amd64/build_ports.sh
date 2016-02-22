#!/bin/sh

# -- check for root --
if [ "`id -u`" != "0" ]; then
  echo "ports.sh: sorry, this must be done as root." 1>&2
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
cd /usr/ports/net/svnup && make $target || exit 1
cd /usr/ports/net/dhcpcd && make $target || exit 1
cd /usr/ports/editors/hexedit && make $target || exit 1
cd /usr/ports/archivers/gtar && make $target || exit 1
cd /usr/ports/archivers/unrar && make $target || exit 1
cd /usr/ports/archivers/p7zip && make $target || exit 1
cd /usr/ports/sysutils/cdrtools && make $target || exit 1
cd /usr/ports/sysutils/dmidecode && make $target || exit 1
cd /usr/ports/sysutils/smartmontools && make $target || exit 1
cd /usr/ports/lang/python3 && make $target || exit 1
cd /usr/ports/lang/python && make $target || exit 1
cd /usr/ports/ftp/curl && make $target || exit 1
cd /usr/ports/ftp/wget && make $target || exit 1
cd /usr/ports/net/samba43 && make $target || exit 1
cd /usr/ports/www/fcgiwrap && make $target || exit 1
cd /usr/ports/www/uwsgi && make $target || exit 1
cd /usr/ports/www/nginx && make $target || exit 1
cd /usr/ports/local/vcs_webpages && make $target || exit 1
cd /usr/ports/local/nas_webpages && make $target || exit 1
cd /usr/ports/devel/mercurial && make $target || exit 1
cd /usr/ports/local/hgweb_config_file_from_env && make $target || exit 1
cd /usr/ports/devel/git && make $target || exit 1
cd /usr/ports/devel/fossil && make $target || exit 1
cd /usr/ports/devel/cscope && make $target || exit 1
cd /usr/ports/benchmarks/iperf && make $target || exit 1
