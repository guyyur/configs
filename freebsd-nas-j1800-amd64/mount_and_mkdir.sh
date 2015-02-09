#!/bin/sh

# -- check for root --
if [ "`id -u`" != "0" ]; then
  echo "mount_and_mkdir.sh: sorry, this must be done as root." 1>&2
  exit 1
fi


# -- disk names --
disk0=ada0
disk1=ada1


# -- layout --
mount -o noatime /dev/"${disk0}"p2 /mnt || exit 1
install -d -m 755 -o root -g wheel /mnt/boot || exit 1
# install -d -m 755 -o root -g wheel /mnt/boot/esp || exit 1
install -d -m 755 -o root -g wheel /mnt/var || exit 1
install -d -m 755 -o root -g wheel /mnt/usr || exit 1
install -d -m 755 -o root -g wheel /mnt/usr/obj || exit 1
install -d -m 755 -o root -g wheel /mnt/home || exit 1
install -d -m 755 -o root -g wheel /mnt/export || exit 1
install -d -m 755 -o root -g wheel /mnt/export/fbsd-ports || exit 1
install -d -m 755 -o guy -g guy /mnt/export/fbsd-src || exit 1
install -d -m 755 -o root -g wheel /mnt/export/backup || exit 1

# mount -t msdosfs -o noatime /dev/"${disk0}"p1 /mnt/boot/esp || exit 1

mount -o noatime /dev/"${disk0}"p4 /mnt/var || exit 1
install -d -m 755 -o root -g wheel /mnt/var/db || exit 1
install -d -m 755 -o root -g wheel /mnt/var/db/portsnap || exit 1

mount -o noatime /dev/"${disk0}"p5 /mnt/export/fbsd-ports || exit 1

mount -o noatime /dev/"${disk0}"p6 /mnt/export/fbsd-src || exit 1
chown guy:guy /mnt/export/fbsd-src || exit 1

mount -o noatime /dev/"${disk0}"p7 /mnt/var/db/portsnap || exit 1
mount -o noatime /dev/"${disk0}"p8 /mnt/usr/obj || exit 1
mount -o noatime /dev/"${disk0}"p9 /mnt/home || exit 1
mount -o noatime /dev/"${disk1}"p1 /mnt/export/backup || exit 1
