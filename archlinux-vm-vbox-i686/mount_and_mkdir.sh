#!/bin/sh

# -- check for root --
if [ "`id -u`" != "0" ]; then
  echo "mount_and_mkdir.sh: sorry, this must be done as root." 1>&2
  exit 1
fi


# -- layout --
mount -o noatime /dev/sda1 /mnt || exit 1
install -d -m 755 -o root -g root /mnt/var || exit 1
install -d -m 755 -o root -g root /mnt/usr || exit 1
install -d -m 755 -o root -g root /mnt/usr/db || exit 1
install -d -m 1777 -o root -g root /mnt/tmp || exit 1
install -d -m 755 -o root -g root /mnt/home || exit 1
install -d -m 755 -o root -g root /mnt/export || exit 1
install -d -m 555 -o root -g root /mnt/proc || exit 1
install -d -m 555 -o root -g root /mnt/sys || exit 1
install -d -m 755 -o root -g root /mnt/dev || exit 1

mount -o noatime /dev/sda2 /mnt/var || exit 1
mkdir /mnt/var/cache || exit 1
mkdir /mnt/var/cache/pacman || exit 1

mount -o noatime /dev/sda3 /mnt/tmp || exit 1
chmod 1777 /mnt/tmp || exit 1

mount -o noatime /dev/sdc1 /mnt/home || exit 1
mount -o bind /proc /mnt/proc || exit 1
mount -o bind /sys /mnt/sys || exit 1
mount -o bind /dev /mnt/dev || exit 1

mount -o noatime /dev/sdd1 /mnt/var/cache/pacman || exit 1
