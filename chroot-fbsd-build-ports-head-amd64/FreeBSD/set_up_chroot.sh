#!/bin/sh

# -- check for root --
if [ "`id -u`" != "0" ]; then
  echo "extract_dists.sh: sorry, this must be done as root." 1>&2
  exit 1
fi


# -- set up --
mount -F /chroots/chroot-fbsd-build-ports-head-amd64/etc/fstab -a || exit 1

install -d -m 755 -o root -g wheel /chroots/chroot-fbsd-build-ports-head-amd64/var/run || exit 1
cp -f /var/run/resolv.conf /chroots/chroot-fbsd-build-ports-head-amd64/var/run/resolv.conf || exit 1
