#!/bin/sh

# -- check for root --
if [ "$(id -u)" != "0" ]; then
  echo "convert_config_files.sh: sorry, this must be done as root." 1>&2
  exit 1
fi


# -- check arguments --
if [ -z "$1" ]; then
  echo "usage: convert_config_files.sh destdir" 1>&2
  exit 1
fi


# -- set up params --
DESTDIR=${1%/}
if [ -z "${DESTDIR}" ]; then
  chroot_cmd=""
else
  chroot_cmd="chroot ${DESTDIR}"
fi


# -- locale --
eval ${chroot_cmd} locale-gen || exit 1


# -- refind --
# eval ${chroot_cmd} /usr/bin/refind-install --usedefault /dev/sdXY
eval ${chroot_cmd} install -c -o root -g root -m 644 /usr/share/refind/refind_x64.efi /efi/EFI/BOOT/BOOTX64.EFI || exit 1
eval ${chroot_cmd} install -d -o root -g root -m 755 /efi/EFI/BOOT/drivers_x64 || exit 1
eval ${chroot_cmd} install -c -o root -g root -m 644 /usr/share/refind/drivers_x64/ext4_x64.efi /efi/EFI/BOOT/drivers_x64/ext4_x64.efi || exit 1
