#!/bin/sh

# -- check arguments --
if [ "$1" = "-N" ]; then
  echo_mode=1
  shift
fi
if [ -z "$1" ]; then
  echo "usage: config.sh [-N] destdir" 1>&2
  exit 1
fi


# -- check for root --
if [ -z "${echo_mode}" -a "$(id -u)" != "0" ]; then
  echo "config.sh: sorry, this must be done as root." 1>&2
  exit 1
fi


# -- verify endian --
uname_p=$(uname -p)
if [ "${uname_p}" != "aarch64" ]; then
  case ${uname_p} in
    aarch64|amd64|armv7|riscv64) ;;
    *)
      echo "config.sh: endian mismatch between host arch and target arch or unsupported host arch." 1>&2
      exit 1
      ;;
  esac
fi


# -- set up params --
DESTDIR=${1%/}
install_dbdir_arg=${DESTDIR:+-N ${DESTDIR}/etc}


# -- functions --
install_dir()
{
  mode=$1
  owner=$2
  group=$3
  path=$4
  
  if [ -z "${echo_mode}" ]; then
    install -d ${install_dbdir_arg} -m ${mode} -o ${owner} -g ${group} "${DESTDIR}"${path} || exit 1
  else
    echo install -d ${install_dbdir_arg} -m ${mode} -o ${owner} -g ${group} ${DESTDIR}${path}
  fi
}

install_file()
{
  mode=$1
  owner=$2
  group=$3
  src=$4
  dst=${5:-${src}}
  
  if [ -z "${echo_mode}" ]; then
    install -c ${install_dbdir_arg} -m ${mode} -o ${owner} -g ${group} tree${src} "${DESTDIR}"${dst} || exit 1
  else
    echo install -c ${install_dbdir_arg} -m ${mode} -o ${owner} -g ${group} tree${src} ${DESTDIR}${dst}
  fi
}

install_empty_file()
{
  mode=$1
  owner=$2
  group=$3
  dst=$4
  
  if [ -z "${echo_mode}" ]; then
    install -c ${install_dbdir_arg} -m ${mode} -o ${owner} -g ${group} /dev/null "${DESTDIR}"${dst} || exit 1
  else
    echo install -c ${install_dbdir_arg} -m ${mode} -o ${owner} -g ${group} /dev/null ${DESTDIR}${dst}
  fi
}

install_hardlink()
{
  src=$1
  dst=$2
  
  if [ -z "${echo_mode}" ]; then
    install -l h "${DESTDIR}"${src} "${DESTDIR}"${dst} || exit 1
  else
    echo install -l h ${DESTDIR}${src} ${DESTDIR}${dst}
  fi
}

install_symlink()
{
  src=$1
  dst=$2
  
  if [ -z "${echo_mode}" ]; then
    install -l s ${src} "${DESTDIR}"${dst} || exit 1
  else
    echo install -l s ${src} ${DESTDIR}${dst}
  fi
}

chown_symlink()
{
  owner=$1
  group=$2
  file=$3
  
  if [ -z "${echo_mode}" ]; then
    chown -h ${owner}:${group} "${DESTDIR}"${file} || exit 1
  else
    echo chown -h ${owner}:${group} ${DESTDIR}${file}
  fi
}

cap_mkdb_file()
{
  file=$1
  
  if [ -z "${echo_mode}" ]; then
    cap_mkdb "${DESTDIR}"${file} || exit 1
  else
    echo cap_mkdb ${DESTDIR}${file}
  fi
}

pwd_mkdb_file()
{
  dir=$1
  file=$2
  
  if [ -z "${echo_mode}" ]; then
    pwd_mkdb -d "${DESTDIR}"${dir} -p "${DESTDIR}"${file} || exit 1
  else
    echo pwd_mkdb -d ${DESTDIR}${dir} -p ${DESTDIR}${file}
  fi
}


#
install_symlink ../usr/share/zoneinfo/Asia/Jerusalem /etc/localtime

install_file 644 root wheel /etc/login.conf
cap_mkdb_file /etc/login.conf

install_file 640 root wheel /etc/pw.conf

install_file 644 root wheel /etc/group

install_file 600 root wheel /etc/master.passwd /etc/master.passwd.new
pwd_mkdb_file /etc /etc/master.passwd.new

install_file 755 root wheel /etc/rc.d/var-restore

install_dir 755 root wheel /etc/var.backup
install_dir 755 root wheel /etc/var.backup/cache
install_dir 755 root wheel /etc/var.backup/db

install_dir 700 guy guy /var/tmp/guy

install_dir 700 guy guy /etc/var.backup/tmp/guy

install_dir 700 guy guy /home/guy
install_dir 755 guy guy /home/guy/misc

install_file 644 root wheel /etc/make.conf
install_file 644 root wheel /etc/src.conf

install_file 444 root wheel /boot/device.hints

install_file 644 root wheel /boot/loader.conf

install_file 644 root wheel /etc/devfs.conf
install_file 644 root wheel /etc/devfs.rules

install_file 644 root wheel /etc/hostid

install_file 644 root wheel /etc/machine-id

install_file 644 root wheel /etc/sysctl.conf

install_file 644 root wheel /etc/ttys

install_file 644 root wheel /etc/hosts

install_file 644 root wheel /etc/resolv.conf

install_file 644 root wheel /etc/resolvconf.conf

install_file 644 root wheel /etc/nsswitch.conf

install_dir 755 root wheel /etc/ssl/certs
install_dir 700 root wheel /etc/ssl/private

install_file 644 root wheel /etc/fstab

install_file 640 root wheel /root/.profile
install_file 640 root wheel /root/.shrc
install_hardlink /root/.profile /.profile

install_file 644 guy guy /home/guy/.profile
install_file 644 guy guy /home/guy/.shrc

install_file 640 root wheel /root/.cshrc

install_file 644 guy guy /home/guy/.cshrc

install_file 644 root wheel /etc/dhclient-exit-hooks

install_file 640 root wheel /etc/dhclient.conf

install_file 644 root wheel /etc/syslog.conf

install_file 644 root wheel /etc/newsyslog.conf

install_file 644 root wheel /etc/crontab
install_file 644 root wheel /etc/cron.d/at

install_file 644 root wheel /etc/ntp.conf

install_dir 700 guy guy /home/guy/.ssh

install_file 644 root wheel /etc/ssh/ssh_known_hosts
install_file 644 root wheel /etc/ssh/ssh_config
install_file 600 guy guy /home/guy/.ssh/id_ed25519
install_file 644 guy guy /home/guy/.ssh/id_ed25519.pub
install_file 600 guy guy /home/guy/.ssh/id_rsa
install_file 644 guy guy /home/guy/.ssh/id_rsa.pub

install_file 600 root wheel /etc/ssh/ssh_host_rsa_key
install_file 644 root wheel /etc/ssh/ssh_host_rsa_key.pub
install_file 600 root wheel /etc/ssh/ssh_host_ed25519_key
install_file 644 root wheel /etc/ssh/ssh_host_ed25519_key.pub
install_file 644 root wheel /etc/ssh/ssh_host_ed25519_key-cert.pub
install_file 640 root wheel /etc/ssh/sshd_config

install_file 600 guy guy /home/guy/.ssh/authorized_keys

install_file 644 root wheel /etc/rtadvd.conf

install_file 640 root wheel /etc/pf.conf

install_file 640 root wheel /etc/pf_anchor-pd_ipv6_lan.conf.in
install_file 755 root wheel /etc/pf_update_pd_ipv6_lan.sh

install_dir 755 root wheel /etc/wireguard

install_file 600 root wheel /etc/wireguard/wg0.conf

install_file 755 root wheel /etc/rc.d/wireguard_simple

install_file 644 root wheel /etc/rc.conf

install_dir 755 root wheel /usr/local/db

install_dir 755 root wheel /etc/local
install_symlink ../../etc/local /usr/local/etc

install_dir 755 root wheel /var/cache/xdg
install_dir 700 root wheel /var/cache/xdg/root
install_dir 755 root wheel /var/db/xdg
install_dir 700 root wheel /var/db/xdg/root

install_dir 755 root wheel /etc/var.backup/cache/xdg
install_dir 700 root wheel /etc/var.backup/cache/xdg/root
install_dir 755 root wheel /etc/var.backup/db/xdg
install_dir 700 root wheel /etc/var.backup/db/xdg/root

install_dir 700 guy guy /var/cache/xdg/guy
install_dir 700 guy guy /var/db/xdg/guy

install_dir 700 guy guy /etc/var.backup/cache/xdg/guy
install_dir 700 guy guy /etc/var.backup/db/xdg/guy

install_dir 755 guy guy /home/guy/config
install_symlink config /home/guy/.config

install_dir 755 root wheel /usr/local/db/pkg
install_file 644 root wheel /etc/local/pkg.conf

install_dir 755 root wheel /usr/local/db/local_pkg_repo
install_dir 755 root wheel /etc/local/pkg
install_dir 755 root wheel /etc/local/pkg/repos
install_file 644 root wheel /etc/local/pkg/repos/custom.conf
install_file 644 root wheel /etc/local/pkg/repos/FreeBSD.conf

install_file 644 root wheel /etc/local/nanorc

install_file 640 root wheel /root/.zshrc

install_file 644 guy guy /home/guy/.zshrc

install_file 644 root wheel /etc/local/tmux.conf

install_file 755 root wheel /etc/local/dhcpcd.exit-hook

install_dir 755 _dhcp _dhcp /var/db/dhcpcd
install_file 644 root _dhcp /var/db/dhcpcd/duid
install_file 600 root _dhcp /var/db/dhcpcd/secret
install_file 644 root wheel /etc/local/dhcpcd.conf

install_dir 755 _dhcp _dhcp /etc/var.backup/db/dhcpcd
install_file 644 root _dhcp /var/db/dhcpcd/duid /etc/var.backup/db/dhcpcd/duid
install_file 600 root _dhcp /var/db/dhcpcd/secret /etc/var.backup/db/dhcpcd/secret

install_file 644 root wheel /etc/local/dnsmasq-hosts

install_file 644 root wheel /etc/local/dnsmasq-dhcp-hosts

install_file 644 root wheel /etc/local/dnsmasq.conf

install_file 755 root wheel /etc/local/dhcp6c-script
install_file 644 root wheel /var/db/dhcp6c_duid
install_file 600 root wheel /etc/local/dhcp6cctlkey
install_file 644 root wheel /etc/local/dhcp6c.conf

install_file 644 root wheel /var/db/dhcp6c_duid /etc/var.backup/db/dhcp6c_duid

install_dir 755 root wheel /etc/local/openvpn

install_file 644 root wheel /etc/local/openvpn/dh.pem
install_file 644 root wheel /etc/local/openvpn/ca.crt
install_file 600 root wheel /etc/local/openvpn/server.key
install_file 644 root wheel /etc/local/openvpn/server.crt

install_file 644 root wheel /etc/local/openvpn/openvpn.conf