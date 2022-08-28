#!/bin/sh

# -- check for root --
if [ "$(id -u)" != "0" ]; then
  echo "extract_dists.sh: sorry, this must be done as root." 1>&2
  exit 1
fi


# -- check arguments --
if [ $# != 1 ]; then
  echo "usage: extract_dists.sh destdir" 1>&2
  exit 1
fi
destdir=$1


# -- set up params --
DESTDIR=$destdir
DISTDIR=$destdir/usr/local/db/local_base_repos


# -- extract files --
tar -Uxp -C "${DESTDIR}" -f "${DISTDIR}"/base.txz || exit 1
rm -f "${DESTDIR}"/root/.login || exit 1
# tar -Uxp -C "${DESTDIR}" -f "${DISTDIR}"/base-dbg.txz || exit 1
# tar -Uxp -C "${DESTDIR}" -f "${DISTDIR}"/doc.txz || exit 1
tar -Uxp -C "${DESTDIR}" -f "${DISTDIR}"/kernel-MYHW.txz || exit 1
install -d "${DESTDIR}"/efi/EFI || exit 1
install -d "${DESTDIR}"/efi/EFI/BOOT || exit 1
install -c "${DESTDIR}"/boot/loader.efi "${DESTDIR}"/efi/EFI/BOOT/BOOTAA64.EFI || exit 1
install -d "${DESTDIR}"/efi/overlays || exit 1
install -c /usr/local/share/u-boot/u-boot-rpi4/u-boot.bin "${DESTDIR}"/efi/u-boot.bin || exit 1
install -c /usr/local/share/rpi-firmware/armstub8-gic.bin "${DESTDIR}"/efi/armstub8-gic.bin || exit 1
install -c /usr/local/share/rpi-firmware/start4.elf "${DESTDIR}"/efi/start4.elf || exit 1
install -c /usr/local/share/rpi-firmware/fixup4.dat "${DESTDIR}"/efi/fixup4.dat || exit 1
install -c /usr/local/share/rpi-firmware/overlays/mmc.dtbo "${DESTDIR}"/efi/overlays/mmc.dtbo || exit 1
install -c /usr/local/share/rpi-firmware/overlays/disable-bt.dtbo "${DESTDIR}"/efi/overlays/disable-bt.dtbo || exit 1
install -c /usr/local/share/rpi-firmware/config_rpi4.txt "${DESTDIR}"/efi/config.txt || exit 1
install -c /usr/local/share/rpi-firmware/bcm2711-rpi-4-b.dtb "${DESTDIR}"/efi/bcm2711-rpi-4-b.dtb || exit 1
