#!/bin/sh

# -- check for root --
if [ "`id -u`" != "0" ]; then
  echo "extract_dists.sh: sorry, this must be done as root." 1>&2
  exit 1
fi


# -- set up --
if [ "$(uname -p)" != "armv7" ]; then
  cp -f /usr/local/bin/qemu-arm-static /chroots/chroot-fbsd-build-ports-head-armv7/root/qemu-arm-static || exit 1
  binmiscctl add armelf --interpreter /root/qemu-arm-static --magic "\x7f\x45\x4c\x46\x01\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x28\x00" --mask  "\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff\xff" --size 20 --set-enabled || exit 1
fi

mount -F /chroots/chroot-fbsd-build-ports-head-armv7/etc/fstab -a || exit 1

install -d -m 755 -o root -g wheel /chroots/chroot-fbsd-build-ports-head-armv7/var/run || exit 1
cp -f /var/run/resolv.conf /chroots/chroot-fbsd-build-ports-head-armv7/var/run/resolv.conf || exit 1
