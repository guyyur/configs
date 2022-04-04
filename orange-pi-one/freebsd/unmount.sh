#!/bin/sh

# -- check for root --
if [ "$(id -u)" != "0" ]; then
  echo "unmount.sh: sorry, this must be done as root." 1>&2
  exit 1
fi


# -- layout --
umount /mnt/home || exit 1
umount /mnt/export/sources || exit 1
umount /mnt/export/packages || exit 1
umount /mnt/boot/ESP || exit 1
umount /mnt/tmp || exit 1
umount /mnt/var || exit 1
umount /mnt/dev || exit 1
umount /mnt || exit 1