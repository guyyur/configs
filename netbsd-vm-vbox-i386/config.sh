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
install -d -m 755 -o root -g wheel "${DESTDIR}"/home/ncvs || exit 1
install -d -m 755 -o root -g wheel "${DESTDIR}"/home/ncvs/src || exit 1
install -d -m 755 -o root -g wheel "${DESTDIR}"/home/ncvs/pkgsrc || exit 1

install -d -m 755 -o root -g wheel "${DESTDIR}"/usr/src || exit 1

install -c -m 644 -o root -g wheel tree/etc/login.conf "${DESTDIR}"/etc/login.conf || exit 1
if [ -z "${DESTDIR}" ]; then
  cap_mkdb /etc/login.conf || exit 1
fi
if [ -n "${DESTDIR}" ]; then
  cap_mkdb -l "${DESTDIR}"/etc/login.conf || exit 1
fi

install -c -m 644 -o root -g wheel tree/etc/usermgmt.conf "${DESTDIR}"/etc/usermgmt.conf || exit 1

# install -c -m 644 -o root -g wheel tree/etc/group "${DESTDIR}"/etc/group || exit 1
# install -c -m 600 -o root -g wheel tree/etc/master.passwd "${DESTDIR}"/etc/master.passwd.new || exit 1
# if [ -z "${DESTDIR}" ]; then
#   pwd_mkdb -p /etc/master.passwd.new || exit 1
# fi
# if [ -n "${DESTDIR}" ]; then
#   pwd_mkdb -d "${DESTDIR}" -L -p "${DESTDIR}"/etc/master.passwd.new || exit 1
# fi

install -d -m 700 -o guy -g users "${DESTDIR}"/home/guy || exit 1
install -d -m 755 -o guy -g users "${DESTDIR}"/home/guy/misc || exit 1
install -d -m 755 -o guy -g users "${DESTDIR}"/home/guy/projects || exit 1

install -d -m 755 -o root -g wheel "${DESTDIR}"/var/xdg-cache || exit 1
install -d -m 700 -o guy -g users "${DESTDIR}"/var/xdg-cache/guy || exit 1

install -d -m 1777 -o root -g users "${DESTDIR}"/home/public || exit 1
install -d -m 1777 -o root -g users "${DESTDIR}"/home/shares || exit 1
install -d -m 0700 -o guy -g users "${DESTDIR}"/home/shares/guy || exit 1

install -c -m 640 -o root -g wheel tree/root/dot.profile "${DESTDIR}"/root/.profile || exit 1
install -c -m 640 -o root -g wheel tree/root/dot.shrc "${DESTDIR}"/root/.shrc || exit 1
install -l h "${DESTDIR}"/root/.profile "${DESTDIR}"/.profile || exit 1
install -c -m 644 -o guy -g users tree/home/guy/dot.profile "${DESTDIR}"/home/guy/.profile || exit 1
install -c -m 644 -o guy -g users tree/home/guy/dot.shrc "${DESTDIR}"/home/guy/.shrc || exit 1

install -c -m 640 -o root -g wheel tree/root/dot.cshrc "${DESTDIR}"/root/.cshrc || exit 1
install -c -m 640 -o root -g wheel tree/root/dot.login "${DESTDIR}"/root/.login || exit 1
install -l h "${DESTDIR}"/root/.cshrc "${DESTDIR}"/.cshrc || exit 1
install -c -m 644 -o guy -g users tree/home/guy/dot.cshrc "${DESTDIR}"/home/guy/.cshrc || exit 1
install -c -m 644 -o guy -g users tree/home/guy/dot.login "${DESTDIR}"/home/guy/.login || exit 1

install -c -m 644 -o root -g wheel tree/boot.cfg "${DESTDIR}"/boot.cfg || exit 1

install -c -m 640 -o root -g wheel tree/etc/sysctl.conf "${DESTDIR}"/etc/sysctl.conf || exit 1

install -c -m 644 -o root -g wheel tree/etc/ttys "${DESTDIR}"/etc/ttys || exit 1

install -c -m 644 -o root -g wheel tree/etc/hosts "${DESTDIR}"/etc/hosts || exit 1

install -l s /var/run/resolv.conf "${DESTDIR}"/etc/resolv.conf || exit 1
chown -h root:wheel "${DESTDIR}"/etc/resolv.conf || exit 1

install -c -m 644 -o root -g wheel tree/etc/nsswitch.conf "${DESTDIR}"/etc/nsswitch.conf || exit 1

install -c -m 644 -o root -g wheel tree/etc/COPYRIGHT "${DESTDIR}"/etc/COPYRIGHT || exit 1

# install -c -m 644 -o root -g wheel tree/etc/motd "${DESTDIR}"/etc/motd || exit 1

install -c -m 644 -o root -g wheel tree/etc/mk.conf "${DESTDIR}"/etc/mk.conf || exit 1

# install -c -m 640 -o root -g wheel tree/etc/ntp.conf "${DESTDIR}"/etc/ntp.conf || exit 1

install -c -m 640 -o root -g wheel tree/etc/syslog.conf "${DESTDIR}"/etc/syslog.conf || exit 1
install -c -m 640 -o root -g wheel tree/etc/newsyslog.conf "${DESTDIR}"/etc/newsyslog.conf || exit 1

install -c -m 644 -o root -g wheel tree/etc/daily.conf "${DESTDIR}"/etc/daily.conf || exit 1

# install -c -m 644 -o root -g wheel tree/etc/ssh/ssh_known_hosts "${DESTDIR}"/etc/ssh/ssh_known_hosts || exit 1
install -c -m 644 -o root -g wheel tree/etc/ssh/ssh_config "${DESTDIR}"/etc/ssh/ssh_config || exit 1

install -d -m 700 -o guy -g users "${DESTDIR}"/home/guy/.ssh || exit 1
# install -c -m 600 -o guy -g users tree/home/guy/dot.ssh/id_rsa "${DESTDIR}"/home/guy/.ssh/id_rsa || exit 1

rm -f "${DESTDIR}"/etc/skel/.ssh/authorized_keys || exit 1
if [ -d "${DESTDIR}"/etc/skel/.ssh ]; then
  rmdir "${DESTDIR}"/etc/skel/.ssh || exit 1
fi
# install -c -m 600 -o root -g wheel tree/etc/ssh/ssh_host_dsa_key "${DESTDIR}"/etc/ssh/ssh_host_dsa_key || exit 1
# install -c -m 644 -o root -g wheel tree/etc/ssh/ssh_host_dsa_key.pub "${DESTDIR}"/etc/ssh/ssh_host_dsa_key.pub || exit 1
# install -c -m 600 -o root -g wheel tree/etc/ssh/ssh_host_ecdsa_key "${DESTDIR}"/etc/ssh/ssh_host_ecdsa_key || exit 1
# install -c -m 644 -o root -g wheel tree/etc/ssh/ssh_host_ecdsa_key.pub "${DESTDIR}"/etc/ssh/ssh_host_ecdsa_key.pub || exit 1
# install -c -m 600 -o root -g wheel tree/etc/ssh/ssh_host_rsa_key "${DESTDIR}"/etc/ssh/ssh_host_rsa_key || exit 1
# install -c -m 644 -o root -g wheel tree/etc/ssh/ssh_host_rsa_key.pub "${DESTDIR}"/etc/ssh/ssh_host_rsa_key.pub || exit 1
# install -c -m 600 -o root -g wheel /dev/null "${DESTDIR}"/etc/ssh/ssh_host_key || exit 1
# install -c -m 644 -o root -g wheel /dev/null "${DESTDIR}"/etc/ssh/ssh_host_key.pub || exit 1
install -c -m 640 -o root -g wheel tree/etc/ssh/sshd_config "${DESTDIR}"/etc/ssh/sshd_config || exit 1

install -d -m 700 -o guy -g users "${DESTDIR}"/home/guy/.ssh || exit 1
# install -c -m 600 -o guy -g users tree/home/guy/dot.ssh/authorized_keys "${DESTDIR}"/home/guy/.ssh/authorized_keys || exit 1

install -c -m 640 -o root -g wheel tree/etc/rc.conf "${DESTDIR}"/etc/rc.conf || exit 1

install -d -m 755 -o root -g wheel "${DESTDIR}"/usr/pkgsrc || exit 1
install -d -m 755 -o root -g wheel "${DESTDIR}"/usr/pkg || exit 1

install -c -m 644 -o root -g wheel tree/etc/nanorc "${DESTDIR}"/etc/nanorc || exit 1
