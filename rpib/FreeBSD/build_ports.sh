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
cd /usr/ports/net/dhcpcd && make $target || exit 1
cd /usr/ports/lang/python && make $target || exit 1
cd /usr/ports/www/fcgiwrap && make $target || exit 1
cd /usr/ports/www/uwsgi && make $target || exit 1
cd /usr/ports/www/nginx && make $target || exit 1
cd /usr/ports/devel/mercurial && make $target || exit 1
cd /usr/ports/local/hgweb_config_file_from_env && make $target || exit 1
cd /usr/ports/devel/git && make $target || exit 1
cd /usr/ports/devel/fossil && make $target || exit 1
cd /usr/ports/benchmarks/iperf && make $target || exit 1
