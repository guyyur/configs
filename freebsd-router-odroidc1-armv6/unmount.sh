#!/bin/sh

# -- check for root --
if [ "`id -u`" != "0" ]; then
  echo "unmount.sh: sorry, this must be done as root." 1>&2
  exit 1
fi


# -- layout --
umount /mnt/misc || exit 1
umount /mnt/var || exit 1
umount /mnt/boot/custom || exit 1
umount /mnt || exit 1
