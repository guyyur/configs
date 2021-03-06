#!/bin/sh

# -- check for root --
if [ "`id -u`" != "0" ]; then
  echo "add_pkgs.sh: sorry, this must be done as root." 1>&2
  exit 1
fi


# -- add pkgs --
pkg install \
  pkg \
  nano \
  zsh \
  dhcpcd \
  samba46 \
  subversion \
  git \
  gdb \
  qemu-user-static \
  || exit 1
