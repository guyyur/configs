#!/bin/sh

# -- check for root --
if [ "`id -u`" != "0" ]; then
  echo "pkgs.sh: sorry, this must be done as root." 1>&2
  exit 1
fi


# -- install --
export PKG_PATH=ftp://ftp.openbsd.org/pub/OpenBSD/"`uname -r`"/packages/"`uname -m`"/

pkg_add tcsh
pkg_add nano
