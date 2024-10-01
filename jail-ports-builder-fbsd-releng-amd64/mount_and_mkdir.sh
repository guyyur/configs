#!/bin/sh

# -- check for root --
if [ "$(id -u)" != "0" ]; then
  echo "mount_and_mkdir.sh: sorry, this must be done as root." 1>&2
  exit 1
fi


# -- disk names --


# -- layout --
mount -t nullfs /jails/ports-builder-fbsd /mnt || exit 1
install -d -m 555 -o root -g wheel /mnt/dev || exit 1
install -d -m 755 -o root -g wheel /mnt/var || exit 1
install -d -m 755 -o root -g wheel /mnt/var/run || exit 1
install -d -m 755 -o root -g wheel /mnt/var/spool || exit 1
install -d -m 755 -o root -g wheel /mnt/var/spool/lock || exit 1
install -d -m 1777 -o root -g wheel /mnt/tmp || exit 1
install -d -m 755 -o root -g wheel /mnt/usr || exit 1
install -d -m 755 -o root -g wheel /mnt/usr/dists || exit 1
install -d -m 755 -o root -g wheel /mnt/home || exit 1

mount -t tmpfs tmpfs /mnt/var/run || exit 1
mount -t tmpfs tmpfs /mnt/var/spool/lock || exit 1

mount -t devfs devfs /mnt/dev || exit 1
mount -t tmpfs tmpfs /mnt/tmp || exit 1
