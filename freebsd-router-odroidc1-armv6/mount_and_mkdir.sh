#!/bin/sh

# -- check for root --
if [ "`id -u`" != "0" ]; then
  echo "mount_and_mkdir.sh: sorry, this must be done as root." 1>&2
  exit 1
fi


# -- disk names --
if [ -z "$1" ]; then
  echo "disk device not specified" 1>&2
  exit 1
fi

disk0=$1


# -- layout --
mount -o noatime /dev/"${disk0}"s2a /mnt || exit 1
install -d -m 755 -o root -g wheel /mnt/boot || exit 1
install -d -m 755 -o root -g wheel /mnt/boot/custom || exit 1
install -d -m 755 -o root -g wheel /mnt/var || exit 1
install -d -m 755 -o root -g wheel /mnt/usr || exit 1
install -d -m 755 -o root -g wheel /mnt/usr/ports || exit 1
install -d -m 755 -o root -g wheel /mnt/usr/wrkdir || exit 1
install -d -m 755 -o root -g wheel /mnt/home || exit 1
install -d -m 755 -o root -g wheel /mnt/misc || exit 1

mount -t msdosfs -o noatime,longnames /dev/"${disk0}"s1 /mnt/boot/custom || exit 1
mount -t tmpfs tmpfs /mnt/var || exit 1
mount -o noatime /dev/"${disk0}"s2d /mnt/misc || exit 1
