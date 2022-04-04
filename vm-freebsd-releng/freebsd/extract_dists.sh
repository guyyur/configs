#!/bin/sh

# -- check for root --
if [ "$(id -u)" != "0" ]; then
  echo "extract_dists.sh: sorry, this must be done as root." 1>&2
  exit 1
fi


# -- check arguments --
if [ $# != 1 ]; then
  echo "usage: extract_dists.sh destdir" 1>&2
  exit 1
fi
destdir=$1


# -- set up params --
DESTDIR=$destdir
DISTDIR=$destdir/usr/local/db/local_base_repos
TARGET_ARCH=amd64


# -- extract files --
tar -Uxp -C "${DESTDIR}" -f "${DISTDIR}"/base.txz || exit 1
rm -f "${DESTDIR}"/root/.login || exit 1
# tar -Uxp -C "${DESTDIR}" -f "${DISTDIR}"/base-dbg.txz || exit 1
# tar -Uxp -C "${DESTDIR}" -f "${DISTDIR}"/doc.txz || exit 1
tar -Uxp -C "${DESTDIR}" -f "${DISTDIR}"/kernel-MYVIRTHW.txz || exit 1
