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
disk4=ada4


# -- layout --
mount -o noatime /dev/"${disk0}"p2 /mnt || exit 1
install -d -m 555 -o root -g wheel /mnt/dev || exit 1
install -d -m 755 -o root -g wheel /mnt/var || exit 1
install -d -m 1777 -o root -g wheel /mnt/tmp || exit 1
install -d -m 755 -o root -g wheel /mnt/usr || exit 1
install -d -m 755 -o root -g wheel /mnt/usr/obj || exit 1
install -d -m 755 -o root -g wheel /mnt/home || exit 1
install -d -m 755 -o root -g wheel /mnt/export || exit 1
install -d -m 755 -o root -g wheel /mnt/chroots || exit 1

mount -t devfs devfs /mnt/dev || exit 1
mount -o noatime /dev/"${disk0}"p3 /mnt/var || exit 1
mount -t tmpfs tmpfs /mnt/tmp || exit 1
mount -o noatime /dev/"${disk2}"p1 /mnt/usr/obj || exit 1
mount -o noatime /dev/"${disk3}"p1 /mnt/home || exit 1

mount -o noatime /dev/"${disk4}"p1 /mnt/chroots || exit 1

install -d -m 755 -o root -g wheel /mnt/usr/wrkdir || exit 1
install -d -m 755 -o root -g wheel /mnt/usr/local || exit 1
install -d -m 755 -o root -g wheel /mnt/usr/local/db || exit 1
install -d -m 755 -o root -g wheel /mnt/usr/local/db/fontconfig || exit 1
install -d -m 755 -o root -g wheel /mnt/usr/local/db/local_pkg_repos || exit 1
install -d -m 755 -o root -g wheel /mnt/usr/local/db/pkg || exit 1
install -d -m 755 -o root -g wheel /mnt/var/xdg-cache || exit 1
install -d -m 700 -o guy -g guy /mnt/var/xdg-cache/guy || exit 1
install -d -m 755 -o guy -g guy /mnt/var/xdg-cache/guy/thumbnails || exit 1
install -d -m 700 -o guy -g guy /mnt/home/guy || exit 1
install -d -m 755 -o guy -g guy /mnt/home/guy/docs || exit 1
install -d -m 755 -o guy -g guy /mnt/home/guy/external_projects || exit 1
install -d -m 755 -o guy -g guy /mnt/home/guy/github || exit 1
install -d -m 755 -o guy -g guy /mnt/home/guy/misc || exit 1
install -d -m 755 -o guy -g guy /mnt/home/guy/misc/fbsd-src || exit 1
install -d -m 755 -o guy -g guy /mnt/home/guy/misc/fbsd-src/releng || exit 1
install -d -m 755 -o guy -g guy /mnt/home/guy/projects || exit 1
install -d -m 755 -o guy -g guy /mnt/home/guy/remove || exit 1
install -d -m 755 -o guy -g guy /mnt/home/guy/sync || exit 1
install -d -m 755 -o guy -g guy /mnt/home/guy/tests || exit 1
install -l s ../../var/xdg-cache/guy/thumbnails /mnt/home/guy/.thumbnails || exit 1
chown -h guy /mnt/home/guy/.thumbnails || exit 1
install -d -m 700 -o guy -g guy /mnt/export/guy || exit 1
install -d -m 755 -o guy -g guy /mnt/export/guy/sync || exit 1
install -d -m 755 -o root -g wheel /mnt/export/obj || exit 1
