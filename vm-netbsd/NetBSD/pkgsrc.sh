#!/bin/sh

# -- check for root --
if [ "`id -u`" != "0" ]; then
  echo "pkgsrc.sh: sorry, this must be done as root." 1>&2
  exit 1
fi


# -- build and install --
cd /usr/pkgsrc/editors/nano && make install clean || exit 1
cd /usr/pkgsrc/shells/zsh && make install clean || exit 1
