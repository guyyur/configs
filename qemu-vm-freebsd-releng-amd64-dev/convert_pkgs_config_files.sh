#!/bin/sh

# -- check for root --
if [ "$(id -u)" != "0" ]; then
  echo "convert_pkgs_config_files.sh: sorry, this must be done as root." 1>&2
  exit 1
fi


# -- check arguments --
if [ -z "$1" ]; then
  echo "usage: convert_pkgs_config_files.sh destdir" 1>&2
  exit 1
fi


# -- set up params --
DESTDIR=${1%/}
if [ -z "${DESTDIR}" ]; then
  chroot_cmd=""
else
  chroot_cmd="chroot ${DESTDIR}"
fi
