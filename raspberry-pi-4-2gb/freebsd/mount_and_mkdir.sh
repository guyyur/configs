#!/bin/sh

# -- check for root --
if [ "$(id -u)" != "0" ]; then
  echo "mount_and_mkdir.sh: sorry, this must be done as root." 1>&2
  exit 1
fi


# -- disk names --
read -p "Enter device for disk0: " disk0 || exit 1


# -- layout --
mount -o noatime /dev/"${disk0}"p2 /mnt || exit 1
install -d -m 555 -o root -g wheel /mnt/dev || exit 1
install -d -m 755 -o root -g wheel /mnt/var || exit 1
install -d -m 1777 -o root -g wheel /mnt/tmp || exit 1
install -d -m 755 -o root -g wheel /mnt/efi || exit 1
install -d -m 755 -o root -g wheel /mnt/usr || exit 1
install -d -m 755 -o root -g wheel /mnt/home || exit 1
install -d -m 755 -o root -g wheel /mnt/backup || exit 1

mount -t devfs devfs /mnt/dev || exit 1
mount -t tmpfs tmpfs /mnt/var || exit 1
mount -t tmpfs tmpfs /mnt/tmp || exit 1
mount -t msdosfs -o noatime,longnames /dev/"${disk0}"p1 /mnt/efi || exit 1
mount -o noatime /dev/"${disk0}"p4 /mnt/backup || exit 1

install -d -m 755 -o root -g wheel /mnt/usr/local || exit 1
install -d -m 755 -o root -g wheel /mnt/usr/local/db || exit 1
install -d -m 755 -o root -g wheel /mnt/usr/local/db/local_base_repos || exit 1
install -d -m 755 -o root -g wheel /mnt/usr/local/db/local_pkg_repos || exit 1
install -d -m 755 -o root -g wheel /mnt/usr/local/db/pkg || exit 1
install -d -m 1777 -o root -g wheel /mnt/var/tmp || exit 1
install -d -m 700 -o guy -g guy /mnt/var/tmp/guy || exit 1
install -d -m 755 -o root -g wheel /mnt/var/xdg-cache || exit 1
install -d -m 700 -o root -g wheel /mnt/var/xdg-cache/root || exit 1
install -d -m 700 -o guy -g guy /mnt/var/xdg-cache/guy || exit 1
install -d -m 700 -o guy -g guy /mnt/home/guy || exit 1
install -d -m 755 -o guy -g guy /mnt/home/guy/misc || exit 1
install -d -m 755 -o guy -g guy /mnt/home/guy/remove || exit 1
