#!/bin/sh

# -- check for root --
if [ "`id -u`" != "0" ]; then
  echo "extract_dists.sh: sorry, this must be done as root." 1>&2
  exit 1
fi


# -- check arguments --
if [ $# != 2 ]; then
  echo "usage: extract_dists.sh destdir dists-dir" 1>&2
  exit 1
fi
destdir=$1
distsdir=$2


# -- set up params --
DESTDIR=$destdir
TARGET_ARCH=amd64


# -- extract files --
tar -Uxp -C "${DESTDIR}" -f "$distsdir"/"${TARGET_ARCH}"/base.txz || exit 1
rm -f "${DESTDIR}"/root/.login || exit 1
# tar -Uxp -C "${DESTDIR}" -f "$distsdir"/"${TARGET_ARCH}"/base-dbg.txz || exit 1
# tar -Uxp -C "${DESTDIR}" -f "$distsdir"/"${TARGET_ARCH}"/doc.txz || exit 1
if [ "$(uname -p)" != "${TARGET_ARCH}" ]; then
  tar -Uxp -C "${DESTDIR}" -f "$distsdir"/"${TARGET_ARCH}"/nxb-bin.txz || exit 1
  (cd "$distsdir" && env DESTDIR="${DESTDIR}" ./set_up_native_xtools.sh) || exit 1
fi
