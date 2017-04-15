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
rm -f "${DESTDIR}"/root/.login || exit 1
# tar -Uxp -C "${DESTDIR}" -f base-dbg.txz || exit 1
# tar -Uxp -C "${DESTDIR}" -f doc.txz || exit 1
tar -Uxp -C "${DESTDIR}" -f kernel-MYHW.txz || exit 1
install -c "${DESTDIR}"/boot/ubldr.bin "${DESTDIR}"/boot/custom/ubldr.bin || exit 1
install -c /usr/local/share/dtb/arm/sun8i-h3-orangepi-one.dtb "${DESTDIR}"/boot/custom/sun8i-h3-orangepi-one.dtb || exit 1
