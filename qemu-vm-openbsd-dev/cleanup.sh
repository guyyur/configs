#!/bin/sh

# -- check for root --
if [ "$(id -u)" != "0" ]; then
  echo "cleanup.sh: sorry, this must be done as root." 1>&2
  exit 1
fi


# -- check arguments --
if [ -z "$1" ]; then
  echo "usage: cleanup.sh destdir" 1>&2
  exit 1
fi
DESTDIR=${1%/}


#
rm -f "${DESTDIR}"/root/.cvsrc || exit 1

rm -f "${DESTDIR}"/root/.Xdefaults || exit 1
