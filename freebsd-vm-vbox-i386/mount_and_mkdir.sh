#!/bin/sh

# -- check for root --
if [ "`id -u`" != "0" ]; then
  echo "mount_and_mkdir.sh: sorry, this must be done as root." 1>&2
  exit 1
fi


# -- disk names --
disk0=ada0
disk1=ada1
disk2=ada2
disk3=ada3


# -- layout --
mount -o noatime /dev/"${disk0}"p2 /mnt || exit 1
install -d -m 755 -o root -g wheel /mnt/var || exit 1
install -d -m 755 -o root -g wheel /mnt/usr || exit 1
install -d -m 755 -o root -g wheel /mnt/usr/obj || exit 1
install -d -m 1777 -o root -g wheel /mnt/tmp || exit 1
install -d -m 755 -o root -g wheel /mnt/home || exit 1
install -d -m 755 -o root -g wheel /mnt/export || exit 1

mount -o noatime /dev/"${disk0}"p3 /mnt/var || exit 1
mount -o noatime /dev/"${disk0}"p4 /mnt/tmp || exit 1
chmod 1777 /mnt/tmp || exit 1

mount -o noatime /dev/"${disk2}"p1 /mnt/home || exit 1
mount -o noatime /dev/"${disk3}"p1 /mnt/usr/obj || exit 1
