#!/bin/sh

# -- check for root --
if [ "`id -u`" != "0" ]; then
  echo "bootfiles.sh: sorry, this must be done as root." 1>&2
  exit 1
fi


# -- check arguments --
if [ $# != 1 ]; then
  echo "usage: bootfiles.sh destdir" 1>&2
  exit 1
fi
DESTDIR=${1%/}


# -- copy files --
install -c /boot/custom/MLO "${DESTDIR}"/boot/custom/MLO || exit 1
install -c /boot/custom/u-boot.img "${DESTDIR}"/boot/custom/u-boot.img || exit 1
install -c "${DESTDIR}"/boot/ubldr.bin "${DESTDIR}"/boot/custom/ubldr.bin || exit 1
install -c "${DESTDIR}"/boot/ubldr "${DESTDIR}"/boot/custom/ubldr || exit 1
install -c "${DESTDIR}"/boot/dtb/beaglebone-black.dtb "${DESTDIR}"/boot/custom/beaglebone-black.dtb || exit 1
