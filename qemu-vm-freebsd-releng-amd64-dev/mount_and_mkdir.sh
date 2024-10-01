#!/bin/sh

# -- check for root --
if [ "$(id -u)" != "0" ]; then
  echo "mount_and_mkdir.sh: sorry, this must be done as root." 1>&2
  exit 1
fi


# -- disk names --
disk0=da0
disk1=da1
disk2=da2
disk3=da3
disk4=da4
disk5=da5


# -- layout --
mount -o noatime /dev/"${disk0}"p2 /mnt || exit 1
install -d -m 555 -o root -g wheel /mnt/dev || exit 1
install -d -m 755 -o root -g wheel /mnt/var || exit 1
install -d -m 1777 -o root -g wheel /mnt/tmp || exit 1
install -d -m 755 -o root -g wheel /mnt/efi || exit 1
install -d -m 755 -o root -g wheel /mnt/usr || exit 1
install -d -m 755 -o root -g wheel /mnt/usr/dists || exit 1
install -d -m 755 -o root -g wheel /mnt/usr/obj || exit 1
install -d -m 755 -o root -g wheel /mnt/usr/wrkdir_large || exit 1
install -d -m 755 -o root -g wheel /mnt/home || exit 1
install -d -m 755 -o root -g wheel /mnt/export || exit 1
install -d -m 755 -o root -g wheel /mnt/jails || exit 1

mount -o noatime /dev/"${disk0}"p3 /mnt/var || exit 1
install -d -m 755 -o root -g wheel /mnt/var/run || exit 1
install -d -m 755 -o root -g wheel /mnt/var/spool || exit 1
install -d -m 755 -o root -g wheel /mnt/var/spool/lock || exit 1

mount -t msdosfs -o noatime,longnames /dev/"${disk0}"p1 /mnt/efi || exit 1
mount -o noatime /dev/"${disk2}"p1 /mnt/usr/obj || exit 1
mount -o noatime /dev/"${disk3}"p1 /mnt/jails || exit 1
mount -o noatime /dev/"${disk4}"p1 /mnt/home || exit 1
mount -o noatime /dev/"${disk5}"p1 /mnt/usr/wrkdir_large || exit 1

mount -t tmpfs tmpfs /mnt/var/run || exit 1
mount -t tmpfs tmpfs /mnt/var/spool/lock || exit 1

mount -t devfs devfs /mnt/dev || exit 1
mount -t tmpfs tmpfs /mnt/tmp || exit 1
