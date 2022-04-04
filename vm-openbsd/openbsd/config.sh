#!/bin/sh

# -- check for root --
if [ "$(id -u)" != "0" ]; then
  echo "config.sh: sorry, this must be done as root." 1>&2
  exit 1
fi


# -- check arguments --
if [ -z "$1" ]; then
  echo "usage: config.sh destdir" 1>&2
  exit 1
fi
DESTDIR=${1%/}
TARGET_ARCH=amd64


#
install -c -m 644 -o root -g wheel tree/etc/login.conf "${DESTDIR}"/etc/login.conf || exit 1

install -c -m 644 -o root -g wheel tree/etc/usermgmt.conf "${DESTDIR}"/etc/usermgmt.conf || exit 1

install -c -m 644 -o root -g wheel tree/etc/group "${DESTDIR}"/etc/group || exit 1
install -c -m 600 -o root -g wheel tree/etc/master.passwd "${DESTDIR}"/etc/master.passwd.new || exit 1
if [ -z "${DESTDIR}" ]; then
  pwd_mkdb -p /etc/master.passwd.new || exit 1
else
  if [ "${TARGET_ARCH}" != "$(uname -p)" ]; then
    printf "pwd_mkdb does not support an endian flag, run on same endianness ${TARGET_ARCH}\n" 1>&2
    exit 1
  else
    pwd_mkdb -d "${DESTDIR}"/etc -p "${DESTDIR}"/etc/master.passwd.new || exit 1
  fi
fi

install -c -m 644 -o root -g wheel tree/etc/ttys "${DESTDIR}"/etc/ttys || exit 1

install -c -m 644 -o root -g wheel tree/etc/hostname.vio0 "${DESTDIR}"/etc/hostname.vio0 || exit 1

install -c -m 644 -o root -g wheel tree/etc/hosts "${DESTDIR}"/etc/hosts || exit 1

ln -sfh ../var/run/resolv.conf "${DESTDIR}"/etc/resolv.conf || exit 1
chown -h root:wheel "${DESTDIR}"/etc/resolv.conf || exit 1

install -c -m 644 -o root -g wheel tree/etc/motd "${DESTDIR}"/etc/motd || exit 1

install -c -m 640 -o root -g wheel tree/root/.profile "${DESTDIR}"/root/.profile || exit 1
install -c -m 640 -o root -g wheel tree/root/.shrc "${DESTDIR}"/root/.shrc || exit 1
ln -f "${DESTDIR}"/root/.profile "${DESTDIR}"/.profile || exit 1
install -c -m 644 -o guy -g users tree/home/guy/.profile "${DESTDIR}"/home/guy/.profile || exit 1
install -c -m 644 -o guy -g users tree/home/guy/.shrc "${DESTDIR}"/home/guy/.shrc || exit 1

install -c -m 644 -o root -g wheel tree/etc/ssh/ssh_known_hosts "${DESTDIR}"/etc/ssh/ssh_known_hosts || exit 1
install -c -m 644 -o root -g wheel tree/etc/ssh/ssh_config "${DESTDIR}"/etc/ssh/ssh_config || exit 1

install -d -m 700 -o guy -g users "${DESTDIR}"/home/guy/.ssh || exit 1
install -c -m 600 -o guy -g users tree/home/guy/.ssh/id_ed25519 "${DESTDIR}"/home/guy/.ssh/id_ed25519 || exit 1
install -c -m 644 -o guy -g guy tree/home/guy/.ssh/id_ed25519.pub "${DESTDIR}"/home/guy/.ssh/id_ed25519.pub || exit 1
install -c -m 600 -o guy -g users tree/home/guy/.ssh/id_rsa "${DESTDIR}"/home/guy/.ssh/id_rsa || exit 1
install -c -m 644 -o guy -g guy tree/home/guy/.ssh/id_rsa.pub "${DESTDIR}"/home/guy/.ssh/id_rsa.pub || exit 1

install -c -m 600 -o root -g wheel tree/etc/ssh/ssh_host_ed25519_key "${DESTDIR}"/etc/ssh/ssh_host_ed25519_key || exit 1
install -c -m 644 -o root -g wheel tree/etc/ssh/ssh_host_ed25519_key.pub "${DESTDIR}"/etc/ssh/ssh_host_ed25519_key.pub || exit 1
install -c -m 644 -o root -g wheel tree/etc/ssh/ssh_host_ed25519_key-cert.pub "${DESTDIR}"/etc/ssh/ssh_host_ed25519_key-cert.pub || exit 1
install -c -m 600 -o root -g wheel tree/etc/ssh/ssh_host_rsa_key "${DESTDIR}"/etc/ssh/ssh_host_rsa_key || exit 1
install -c -m 644 -o root -g wheel tree/etc/ssh/ssh_host_rsa_key.pub "${DESTDIR}"/etc/ssh/ssh_host_rsa_key.pub || exit 1
install -c -m 640 -o root -g wheel tree/etc/ssh/sshd_config "${DESTDIR}"/etc/ssh/sshd_config || exit 1

install -c -m 600 -o guy -g users tree/home/guy/.ssh/authorized_keys "${DESTDIR}"/home/guy/.ssh/authorized_keys || exit 1

install -c -m 644 -o root -g wheel tree/etc/tmux.conf "${DESTDIR}"/etc/tmux.conf || exit 1

install -c -m 640 -o root -g wheel tree/etc/rc.conf.local "${DESTDIR}"/etc/rc.conf.local || exit 1

install -d -m 755 -o guy -g users "${DESTDIR}"/home/guy/config || exit 1

install -c -m 644 -o root -g wheel tree/etc/nanorc "${DESTDIR}"/etc/nanorc || exit 1

install -c -m 640 -o root -g wheel tree/root/.zshrc "${DESTDIR}"/root/.zshrc || exit 1
install -c -m 644 -o guy -g users tree/home/guy/.zshrc "${DESTDIR}"/home/guy/.zshrc || exit 1
