#!/bin/sh

# -- check for root --
if [ "`id -u`" != "0" ]; then
  echo "unmount.sh: sorry, this must be done as root." 1>&2
  exit 1
fi


# -- layout --
umount /mnt/var/cache/pacman || exit 1
umount /mnt/dev || exit 1
umount /mnt/sys || exit 1
umount /mnt/proc || exit 1
umount /mnt/home || exit 1
umount /mnt/var || exit 1
umount /mnt || exit 1
