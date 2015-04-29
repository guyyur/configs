#!/bin/sh

# -- check for root --
if [ "`id -u`" != "0" ]; then
  echo "extract_dists.sh: sorry, this must be done as root." 1>&2
  exit 1
fi


# -- check arguments --
if [ $# != 2 ]; then
  echo "usage: extract_dists.sh destdir dists-dir" 1>&2
  exit 1
fi
DESTDIR=$1
distsdir=$2


# -- extract files --
cd $distsdir || exit 1

tar -Uxp -C "${DESTDIR}" -f base.txz || exit 1
# tar -Uxp -C "${DESTDIR}" -f doc.txz || exit 1
tar -Uxp -C "${DESTDIR}" -f kernel-ROUTER.txz || exit 1
install -c -m 444 -o root -g wheel "${DESTDIR}"/boot/loader.rc.sample "${DESTDIR}"/boot/loader.rc || exit 1
install -c -m 555 -o root -g wheel ubldr-0x88000000 "${DESTDIR}"/boot/ubldr || exit 1