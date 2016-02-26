#!/bin/sh

# -- check for root --
if [ "`id -u`" != "0" ]; then
  echo "bootloader.sh: sorry, this must be done as root." 1>&2
  exit 1
fi


# -- check arguments --
if [ -z "$1" ]; then
  echo "usage: bootloader.sh destdir" 1>&2
  exit 1
fi
DESTDIR=${1%/}


# -- install --
dd bs=446 count=1 conv=notrunc if="${DESTDIR}/usr/lib/syslinux/bios/mbr.bin" of=/dev/sda || exit 1
"${DESTDIR}"/usr/bin/extlinux --install "${DESTDIR}"/boot/syslinux || exit 1
ln -sfn /usr/lib/syslinux/bios/libutil.c32 "${DESTDIR}"/boot/syslinux/libutil.c32 || exit 1
ln -sfn /usr/lib/syslinux/bios/menu.c32 "${DESTDIR}"/boot/syslinux/menu.c32 || exit 1
