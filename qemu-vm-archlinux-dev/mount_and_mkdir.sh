#!/bin/sh

# -- check for root --
if [ "$(id -u)" != "0" ]; then
  echo "mount_and_mkdir.sh: sorry, this must be done as root." 1>&2
  exit 1
fi


# -- disk names --
disk0p=sda
disk1p=sdb
disk2p=sdc


# -- layout --
mount -o noatime /dev/"${disk0p}"2 /mnt || exit 1
install -d -m 755 -o root -g root /mnt/efi || exit 1
install -d -m 755 -o root -g root /mnt/run || exit 1
install -d -m 755 -o root -g root /mnt/var || exit 1
install -d -m 1777 -o root -g root /mnt/tmp || exit 1
install -d -m 755 -o root -g root /mnt/home || exit 1
install -d -m 755 -o root -g root /mnt/export || exit 1
install -d -m 555 -o root -g root /mnt/proc || exit 1
install -d -m 555 -o root -g root /mnt/sys || exit 1
install -d -m 755 -o root -g root /mnt/dev || exit 1

mount -o noatime /dev/"${disk0p}"1 /mnt/efi || exit 1
mount -o noatime /dev/"${disk0p}"3 /mnt/var || exit 1
mount -o noatime /dev/"${disk2p}"1 /mnt/home || exit 1

mount -o bind /proc /mnt/proc || exit 1
mount -o bind /sys /mnt/sys || exit 1
mount -o bind /dev /mnt/dev || exit 1
mount -t tmpfs tmpfs /mnt/run || exit 1
mount -t tmpfs tmpfs /mnt/tmp || exit 1
