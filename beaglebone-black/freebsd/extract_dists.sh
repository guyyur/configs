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
TARGET_ARCH=armv7


# -- extract files --
tar -Uxp -C "${DESTDIR}" -f "${DISTDIR}"/base.txz || exit 1
rm -f "${DESTDIR}"/root/.login || exit 1
# tar -Uxp -C "${DESTDIR}" -f "${DISTDIR}"/base-dbg.txz || exit 1
# tar -Uxp -C "${DESTDIR}" -f "${DISTDIR}"/doc.txz || exit 1
tar -Uxp -C "${DESTDIR}" -f "${DISTDIR}"/kernel-MYHW.txz || exit 1
install -d "${DESTDIR}"/efi/EFI || exit 1
install -d "${DESTDIR}"/efi/EFI/BOOT || exit 1
case ${TARGET_ARCH} in
  aarch64)
    install -c "${DESTDIR}"/boot/loader.efi "${DESTDIR}"/efi/EFI/BOOT/BOOTAA64.EFI || exit 1
    ;;
  amd64)
    install -c "${DESTDIR}"/boot/loader.efi "${DESTDIR}"/efi/EFI/BOOT/BOOTX64.EFI || exit 1
    ;;
  armv7)
    install -c "${DESTDIR}"/boot/loader.efi "${DESTDIR}"/efi/EFI/BOOT/BOOTARM.EFI || exit 1
    ;;
  *)
    printf "Unknown TARGET_ARCH=${TARGET_ARCH} for EFI boot\n"
    exit 1
    ;;
esac
install -c "${DESTDIR}"/boot/dtb/am335x-boneblack.dtb "${DESTDIR}"/efi/am335x-boneblack.dtb || exit 1
