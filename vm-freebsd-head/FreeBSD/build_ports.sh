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
cd /usr/ports/net/dhcpcd && make $target || exit 1
cd /usr/ports/lang/python3 && make $target || exit 1
cd /usr/ports/ftp/wget && make $target || exit 1
cd /usr/ports/net/samba43 && make $target || exit 1
cd /usr/ports/devel/mercurial && make $target || exit 1
cd /usr/ports/devel/subversion && make $target || exit 1
cd /usr/ports/devel/git && make $target || exit 1
cd /usr/ports/devel/gdb && make $target || exit 1
