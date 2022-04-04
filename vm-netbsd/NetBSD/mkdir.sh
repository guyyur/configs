#!/bin/sh

# -- check for root --
if [ "$(id -u)" != "0" ]; then
  echo "mkdir.sh: sorry, this must be done as root." 1>&2
  exit 1
fi


# -- check arguments --
if [ -z "$1" ]; then
  echo "usage: mkdir.sh destdir" 1>&2
  exit 1
fi
DESTDIR=${1%/}


# -- layout --
install -d -m 755 -o root -g wheel "${DESTDIR}"/usr/pkg || exit 1
install -d -m 755 -o root -g wheel "${DESTDIR}"/var/xdg-cache || exit 1
install -d -m 700 -o guy -g users "${DESTDIR}"/var/xdg-cache/guy || exit 1
install -d -m 700 -o guy -g users "${DESTDIR}"/home/guy || exit 1
install -d -m 755 -o guy -g users "${DESTDIR}"/home/guy/external_projects || exit 1
install -d -m 755 -o guy -g users "${DESTDIR}"/home/guy/misc || exit 1
install -d -m 755 -o guy -g users "${DESTDIR}"/home/guy/projects || exit 1
install -d -m 755 -o guy -g users "${DESTDIR}"/home/guy/remove || exit 1
