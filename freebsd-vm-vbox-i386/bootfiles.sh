#!/bin/sh

# -- check for root --
if [ "`id -u`" != "0" ]; then
  echo "bootfiles.sh: sorry, this must be done as root." 1>&2
  exit 1
fi


# -- check arguments --
if [ $# != 1 ]; then
  echo "usage: bootfiles.sh destdir" 1>&2
  exit 1
fi
DESTDIR=${1%/}


# -- copy files --
