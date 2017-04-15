#!/bin/sh

# -- check for root --
if [ "`id -u`" != "0" ]; then
  echo "remount.sh: sorry, this must be done as root." 1>&2
  exit 1
fi


# -- disk names --
path0=/chroots/build_ports-amd64
src_version=head


# -- layout --
mount -t nullfs "${path0}" /mnt || exit 1
mount -t devfs devfs /mnt/dev || exit 1
mount -t tmpfs tmpfs /mnt/tmp || exit 1
mount -t tmpfs tmpfs /mnt/usr/wrkdir || exit 1
mount -t nfs -orw,nfsv4 fbsd-ports:/ports /mnt/usr/ports || exit 1
mount -t nullfs -oro /home/guy/misc/fbsd-src/"${src_version}" /mnt/usr/src || exit 1
mount -t nfs -orw,nfsv4 packages:/packages /mnt/usr/local/db/local_pkg_repos || exit 1
