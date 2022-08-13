#!/bin/sh

# -- check for root --
if [ "$(id -u)" != "0" ]; then
  echo "mount_and_mkdir.sh: sorry, this must be done as root." 1>&2
  exit 1
fi


# -- disk names --
read -p "Enter device for disk0: " disk0 || exit 1


# -- params --


# -- layout --
mount -o noatime /dev/"${disk0}"p2 /mnt || exit 1
install -d -m 555 -o root -g wheel /mnt/dev || exit 1
install -d -m 755 -o root -g wheel /mnt/var || exit 1
install -d -m 1777 -o root -g wheel /mnt/tmp || exit 1
install -d -m 755 -o root -g wheel /mnt/efi || exit 1
install -d -m 755 -o root -g wheel /mnt/usr || exit 1
install -d -m 755 -o root -g wheel /mnt/home || exit 1
install -d -m 755 -o root -g wheel /mnt/export || exit 1
install -d -m 755 -o root -g wheel /mnt/export/packages || exit 1
install -d -m 755 -o root -g wheel /mnt/export/sources || exit 1
install -d -m 755 -o root -g wheel /mnt/jails || exit 1

mount -t devfs devfs /mnt/dev || exit 1
mount -t tmpfs tmpfs /mnt/var || exit 1
mount -t tmpfs tmpfs /mnt/tmp || exit 1
mount -t msdosfs -o noatime,longnames /dev/"${disk0}"p1 /mnt/efi || exit 1
mount -o noatime /dev/"${disk0}"p4 /mnt/export/packages || exit 1
mount -o noatime /dev/"${disk0}"p5 /mnt/export/sources || exit 1
mount -o noatime /dev/"${disk0}"p6 /mnt/home || exit 1

install -d -m 755 -o root -g wheel /mnt/usr/local || exit 1
install -d -m 755 -o root -g wheel /mnt/usr/local/db || exit 1
install -d -m 755 -o root -g wheel /mnt/usr/local/db/fontconfig || exit 1
install -d -m 755 -o root -g wheel /mnt/usr/local/db/local_base_repos || exit 1
install -d -m 755 -o root -g wheel /mnt/usr/local/db/local_pkg_repos || exit 1
install -d -m 755 -o root -g wheel /mnt/usr/local/db/pkg || exit 1
install -d -m 755 -o root -g wheel /mnt/var/log || exit 1
install -d -m 700 -o guy -g guy /mnt/var/log/guy || exit 1
install -d -m 1777 -o root -g wheel /mnt/var/tmp || exit 1
install -d -m 700 -o guy -g guy /mnt/var/tmp/guy || exit 1
install -d -m 755 -o 0755 -o guy -g guy /var/tmp/guy/nginx || exit 1
install -d -m 755 -o root -g wheel /mnt/var/xdg-cache || exit 1
install -d -m 700 -o root -g wheel /mnt/var/xdg-cache/root || exit 1
install -d -m 700 -o guy -g guy /mnt/var/xdg-cache/guy || exit 1
install -d -m 700 -o guy -g guy /mnt/home/guy || exit 1
install -d -m 755 -o guy -g guy /mnt/home/guy/Downloads || exit 1
install -d -m 755 -o guy -g guy /mnt/home/guy/external_projects || exit 1
install -d -m 755 -o guy -g guy /mnt/home/guy/github || exit 1
install -d -m 755 -o guy -g guy /mnt/home/guy/misc || exit 1
install -d -m 755 -o guy -g guy /mnt/home/guy/projects || exit 1
install -d -m 755 -o guy -g guy /mnt/home/guy/proofing || exit 1
install -d -m 755 -o guy -g guy /mnt/home/guy/remove || exit 1
install -d -m 755 -o guy -g guy /mnt/home/guy/repos_docs || exit 1
install -d -m 755 -o guy -g guy /mnt/home/guy/repos_external_projects || exit 1
install -d -m 755 -o guy -g guy /mnt/home/guy/repos_problems || exit 1
install -d -m 755 -o guy -g guy /mnt/home/guy/repos_projects || exit 1
install -d -m 755 -o guy -g guy /mnt/home/guy/repos_tests || exit 1
install -d -m 755 -o guy -g guy /mnt/home/guy/repos_todo_docs || exit 1
install -d -m 755 -o guy -g guy /mnt/home/guy/repos_todo_external_projects || exit 1
install -d -m 755 -o guy -g guy /mnt/home/guy/repos_todo_projects || exit 1
install -d -m 700 -o guy -g guy /mnt/home/guy/share || exit 1
install -d -m 755 -o guy -g guy /mnt/home/guy/tests || exit 1
install -d -m 777 -o root -g wheel /mnt/home/public || exit 1
install -d -m 700 -o guy -g guy /mnt/export/guy_share || exit 1
install -d -m 755 -o root -g wheel /mnt/export/packages/FreeBSD-base || exit 1
install -d -m 755 -o root -g wheel /mnt/export/packages/FreeBSD-base/head || exit 1
install -d -m 755 -o root -g wheel /mnt/export/packages/FreeBSD-base/head/aarch64 || exit 1
install -d -m 755 -o root -g wheel /mnt/export/packages/FreeBSD-base/head/amd64 || exit 1
install -d -m 755 -o root -g wheel /mnt/export/packages/FreeBSD-base/releng || exit 1
install -d -m 755 -o root -g wheel /mnt/export/packages/FreeBSD-base/releng/aarch64 || exit 1
install -d -m 755 -o root -g wheel /mnt/export/packages/FreeBSD-base/releng/amd64 || exit 1
install -d -m 755 -o root -g wheel /mnt/export/packages/FreeBSD-base/releng/armv7 || exit 1
install -d -m 755 -o root -g wheel /mnt/export/packages/FreeBSD || exit 1
install -d -m 755 -o root -g wheel /mnt/export/packages/FreeBSD/head || exit 1
install -d -m 755 -o root -g wheel /mnt/export/packages/FreeBSD/head/aarch64 || exit 1
install -d -m 755 -o root -g wheel /mnt/export/packages/FreeBSD/head/amd64 || exit 1
install -d -m 755 -o root -g wheel /mnt/export/packages/FreeBSD/releng || exit 1
install -d -m 755 -o root -g wheel /mnt/export/packages/FreeBSD/releng/aarch64 || exit 1
install -d -m 755 -o root -g wheel /mnt/export/packages/FreeBSD/releng/amd64 || exit 1
install -d -m 755 -o root -g wheel /mnt/export/packages/FreeBSD/releng/armv7 || exit 1
install -d -m 755 -o root -g wheel /mnt/export/packages/archlinux || exit 1
install -d -m 755 -o root -g wheel /mnt/export/packages/windows || exit 1
install -d -m 777 -o root -g wheel /mnt/export/public || exit 1
install -d -m 755 -o guy -g guy /mnt/export/sources/freebsd-ports || exit 1
install -d -m 755 -o root -g wheel /mnt/export/sources/arch-pkgbuilds || exit 1
