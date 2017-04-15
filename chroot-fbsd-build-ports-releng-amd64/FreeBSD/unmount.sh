#!/bin/sh

# -- check for root --
if [ "`id -u`" != "0" ]; then
  echo "unmount.sh: sorry, this must be done as root." 1>&2
  exit 1
fi


# -- layout --
umount /mnt/usr/local/db/local_pkg_repos || exit 1
umount /mnt/usr/src || exit 1
umount /mnt/usr/ports || exit 1
umount /mnt/usr/wrkdir || exit 1
umount /mnt/tmp || exit 1
umount /mnt/dev || exit 1
umount /mnt || exit 1
