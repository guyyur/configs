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


# -- layout --
mount -o noatime /dev/"${disk0}"p2 /mnt || exit 1
install -d -m 755 -o root -g wheel /mnt/var || exit 1
install -d -m 755 -o root -g wheel /mnt/usr || exit 1
install -d -m 755 -o root -g wheel /mnt/usr/ports || exit 1
install -d -m 755 -o root -g wheel /mnt/usr/wrkdir || exit 1
install -d -m 755 -o root -g wheel /mnt/home || exit 1
install -d -m 755 -o root -g wheel /mnt/export || exit 1
install -d -m 1777 -o root -g wheel /mnt/export/public || exit 1
install -d -m 1777 -o root -g wheel /mnt/export/shares || exit 1

mount -o noatime /dev/"${disk0}"p3 /mnt/var || exit 1
mount -o noatime /dev/"${disk2}"p1 /mnt/home || exit 1
