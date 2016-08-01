#!/bin/sh

# -- check for root --
if [ "`id -u`" != "0" ]; then
  echo "mount_and_mkdir.sh: sorry, this must be done as root." 1>&2
  exit 1
fi


# -- disk names --
disk0=sda
disk1=sdb
disk2=sdc
disk3=sdd


# -- layout --
mount -o noatime /dev/"${disk0}"1 /mnt || exit 1
install -d -m 755 -o root -g root /mnt/var || exit 1
install -d -m 755 -o root -g root /mnt/usr || exit 1
install -d -m 755 -o root -g root /mnt/usr/db || exit 1
install -d -m 755 -o root -g root /mnt/usr/db/pacman || exit 1
ln -sfn /var/cache/pacman/sync /mnt/usr/db/pacman/sync || exit 1
install -d -m 755 -o root -g root /mnt/home || exit 1
install -d -m 755 -o root -g root /mnt/export || exit 1
install -d -m 1777 -o root -g users /mnt/export/public || exit 1
install -d -m 1777 -o root -g users /mnt/export/shares || exit 1
install -d -m 1777 -o root -g root /mnt/export/pacman || exit 1
install -d -m 555 -o root -g root /mnt/proc || exit 1
install -d -m 555 -o root -g root /mnt/sys || exit 1
install -d -m 755 -o root -g root /mnt/dev || exit 1

mount -o noatime /dev/"${disk0}"2 /mnt/var || exit 1
install -d -m 755 -o root -g root /mnt/var/cache || exit 1
install -d -m 755 -o root -g root /mnt/var/cache/pacman || exit 1

mount -o noatime /dev/"${disk2}"1 /mnt/var/cache/pacman || exit 1
install -d -m 755 -o root -g root /mnt/var/cache/pacman/sync || exit 1

mount -o noatime /dev/"${disk3}"1 /mnt/home || exit 1
mount -o bind /proc /mnt/proc || exit 1
mount -o bind /sys /mnt/sys || exit 1
mount -o bind /dev /mnt/dev || exit 1
