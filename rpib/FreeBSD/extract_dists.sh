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
tar -Uxp -C "${DESTDIR}" -f kernel-MYRPIB.txz || exit 1
install -c "${DESTDIR}"/boot/ubldr.bin "${DESTDIR}"/boot/custom/ubldr.bin || exit 1
install -c /usr/local/share/rpi-firmware/bootcode.bin "${DESTDIR}"/boot/custom/bootcode.bin || exit 1
install -c /usr/local/share/rpi-firmware/fixup.dat "${DESTDIR}"/boot/custom/fixup.dat || exit 1
install -c /usr/local/share/rpi-firmware/fixup_cd.dat "${DESTDIR}"/boot/custom/fixup_cd.dat || exit 1
install -c /usr/local/share/rpi-firmware/fixup_db.dat "${DESTDIR}"/boot/custom/fixup_db.dat || exit 1
install -c /usr/local/share/rpi-firmware/fixup_x.dat "${DESTDIR}"/boot/custom/fixup_x.dat || exit 1
install -c /usr/local/share/rpi-firmware/start.elf "${DESTDIR}"/boot/custom/start.elf || exit 1
install -c /usr/local/share/rpi-firmware/start_cd.elf "${DESTDIR}"/boot/custom/start_cd.elf || exit 1
install -c /usr/local/share/rpi-firmware/start_db.elf "${DESTDIR}"/boot/custom/start_db.elf || exit 1
install -c /usr/local/share/rpi-firmware/start_x.elf "${DESTDIR}"/boot/custom/start_x.elf || exit 1
install -c /usr/local/share/u-boot/u-boot-rpi-custom/u-boot.bin "${DESTDIR}"/boot/custom/u-boot.bin || exit 1
install -c "${DESTDIR}"/boot/dtb/bcm2835-rpi-b-rev2.dtb "${DESTDIR}"/boot/custom/bcm2835-rpi-b-rev2.dtb || exit 1
