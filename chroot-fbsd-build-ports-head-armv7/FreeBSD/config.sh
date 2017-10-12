#!/bin/sh

# -- check for root --
if [ "`id -u`" != "0" ]; then
  echo "config.sh: sorry, this must be done as root." 1>&2
  exit 1
fi


# -- check arguments --
if [ -z "$1" ]; then
  echo "usage: config.sh destdir" 1>&2
  exit 1
fi
DESTDIR=${1%/}


#
install -l s ../usr/share/zoneinfo/Asia/Jerusalem "${DESTDIR}"/etc/localtime || exit 1

install -c -m 644 -o root -g wheel tree/etc/login.conf "${DESTDIR}"/etc/login.conf || exit 1
if [ -z "${DESTDIR}" ]; then
  cap_mkdb /etc/login.conf || exit 1
fi
if [ -n "${DESTDIR}" ]; then
  cap_mkdb -l "${DESTDIR}"/etc/login.conf || exit 1
fi

install -c -m 640 -o root -g wheel tree/etc/pw.conf "${DESTDIR}"/etc/pw.conf || exit 1

install -c -m 644 -o root -g wheel tree/etc/group "${DESTDIR}"/etc/group || exit 1
install -c -m 600 -o root -g wheel tree/etc/master.passwd "${DESTDIR}"/etc/master.passwd.new || exit 1
if [ -n "${DESTDIR}" ]; then
  pwd_mkdb -d "${DESTDIR}"/etc -p "${DESTDIR}"/etc/master.passwd.new || exit 1
else
  pwd_mkdb -p /etc/master.passwd.new || exit 1
fi

install -c -m 644 -o root -g wheel tree/etc/make.conf "${DESTDIR}"/etc/make.conf || exit 1
install -c -m 644 -o root -g wheel tree/etc/src.conf "${DESTDIR}"/etc/src.conf || exit 1

install -l s 'abort:false,junk:false' "${DESTDIR}"/etc/malloc.conf || exit 1

install -c -m 644 -o root -g wheel tree/etc/hosts "${DESTDIR}"/etc/hosts || exit 1

install -l s ../var/run/resolv.conf "${DESTDIR}"/etc/resolv.conf || exit 1

install -c -m 644 -o root -g wheel tree/etc/nsswitch.conf "${DESTDIR}"/etc/nsswitch.conf || exit 1
install -c -m 644 -o root -g wheel tree/etc/host.conf "${DESTDIR}"/etc/host.conf || exit 1

install -d -m 755 -o root -g wheel "${DESTDIR}"/etc/ssl/certs || exit 1
install -d -m 700 -o root -g wheel "${DESTDIR}"/etc/ssl/private || exit 1

install -c -m 644 -o root -g wheel tree/etc/motd "${DESTDIR}"/etc/motd || exit 1

install -c -m 644 -o root -g wheel tree/etc/fstab "${DESTDIR}"/etc/fstab || exit 1

install -c -m 640 -o root -g wheel tree/root/.profile "${DESTDIR}"/root/.profile || exit 1
install -c -m 640 -o root -g wheel tree/root/.shrc "${DESTDIR}"/root/.shrc || exit 1
install -l h "${DESTDIR}"/root/.profile "${DESTDIR}"/.profile || exit 1
install -c -m 644 -o root -g wheel tree/etc/skel/dot.profile "${DESTDIR}"/etc/skel/dot.profile || exit 1
install -c -m 644 -o root -g wheel tree/etc/skel/dot.shrc "${DESTDIR}"/etc/skel/dot.shrc || exit 1
install -c -m 644 -o guy -g guy tree/home/guy/.profile "${DESTDIR}"/home/guy/.profile || exit 1
install -c -m 644 -o guy -g guy tree/home/guy/.shrc "${DESTDIR}"/home/guy/.shrc || exit 1

install -c -m 640 -o root -g wheel tree/root/.cshrc "${DESTDIR}"/root/.cshrc || exit 1
install -l h "${DESTDIR}"/root/.cshrc "${DESTDIR}"/.cshrc || exit 1
install -c -m 644 -o root -g wheel tree/etc/skel/dot.cshrc "${DESTDIR}"/etc/skel/dot.cshrc || exit 1
install -c -m 644 -o guy -g guy tree/home/guy/.cshrc "${DESTDIR}"/home/guy/.cshrc || exit 1

install -c -m 640 -o root -g wheel tree/root/.init.ee "${DESTDIR}"/root/.init.ee || exit 1
install -c -m 644 -o guy -g guy tree/home/guy/.init.ee "${DESTDIR}"/home/guy/.init.ee || exit 1

install -c -m 644 -o root -g wheel tree/etc/mergemaster.rc "${DESTDIR}"/etc/mergemaster.rc || exit 1

install -c -m 644 -o root -g wheel tree/etc/rc.conf "${DESTDIR}"/etc/rc.conf || exit 1

install -d -m 755 -o root -g wheel "${DESTDIR}"/etc/local || exit 1
install -l s ../../etc/local "${DESTDIR}"/usr/local/etc || exit 1

install -d -m 755 -o guy -g guy "${DESTDIR}"/home/guy/config || exit 1

install -c -m 644 -o root -g wheel tree/etc/local/ports.conf "${DESTDIR}"/etc/local/ports.conf || exit 1

install -c -m 644 -o root -g wheel tree/etc/local/portmaster.rc "${DESTDIR}"/etc/local/portmaster.rc || exit 1

install -c -m 644 -o root -g wheel tree/etc/local/pkg.conf "${DESTDIR}"/etc/local/pkg.conf || exit 1

install -c -m 644 -o root -g wheel tree/etc/local/nanorc "${DESTDIR}"/etc/local/nanorc || exit 1

install -c -m 640 -o root -g wheel tree/root/.zshrc "${DESTDIR}"/root/.zshrc || exit 1
install -c -m 644 -o guy -g guy tree/home/guy/.zshrc "${DESTDIR}"/home/guy/.zshrc || exit 1

install -d -m 755 -o root -g wheel "${DESTDIR}"/etc/local/fonts || exit 1
install -c -m 644 -o root -g wheel tree/etc/local/fonts/local.conf "${DESTDIR}"/etc/local/fonts/local.conf || exit 1
