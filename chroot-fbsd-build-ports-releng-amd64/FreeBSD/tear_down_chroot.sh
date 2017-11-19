#!/bin/sh

# -- check for root --
if [ "`id -u`" != "0" ]; then
  echo "extract_dists.sh: sorry, this must be done as root." 1>&2
  exit 1
fi


# -- tear down --
umount -F /chroots/chroot-fbsd-build-ports-releng-amd64/etc/fstab -a || exit 1
