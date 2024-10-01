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

install_dir 700 guy guy /var/log/guy

install_dir 700 guy guy /var/tmp/guy

install_dir 700 guy guy /home/guy
install_dir 755 guy guy /home/guy/Downloads
install_dir 755 guy guy /home/guy/external_projects
install_dir 755 guy guy /home/guy/github
install_dir 755 guy guy /home/guy/misc
install_dir 755 guy guy /home/guy/projects
install_dir 755 guy guy /home/guy/remove
install_dir 755 guy guy /home/guy/sync
install_dir 755 guy guy /home/guy/sync/phone
install_dir 755 guy guy /home/guy/tests

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

install_symlink ../var/run/resolv.conf /etc/resolv.conf
# chown_symlink root wheel /etc/resolv.conf

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

install_file 644 root wheel /etc/syslog.conf

install_file 644 root wheel /etc/newsyslog.conf

install_file 644 root wheel /etc/crontab
install_file 644 root wheel /etc/cron.d/at

install_file 644 root wheel /etc/ntp.conf

install_dir 755 unbound unbound /var/unbound
install_empty_file 644 root unbound /var/unbound/forward.conf
install_file 644 root unbound /var/unbound/unbound.conf

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

install_dir 755 root wheel /jails/base-jail

# install_dir 755 root wheel /jails/...-jail
# install_dir 755 root wheel /jails/...-jail.root
# install_dir 755 root wheel /jails/...-jail.etc
# install_dir 755 root wheel /jails/...-jail.usr-local
# install_dir 755 root wheel /home/...-jail.home

install_file 644 root wheel /etc/jail.conf

install_dir 755 root wheel /export/packages/freebsd-base
install_dir 755 root wheel /export/packages/freebsd-base/14.1
install_dir 755 root wheel /export/packages/freebsd-base/14.1/aarch64
install_dir 755 root wheel /export/packages/freebsd-base/14.1/amd64
install_dir 755 root wheel /export/packages/freebsd-base/14.1/armv7
install_dir 755 root wheel /export/packages/freebsd-base/head
install_dir 755 root wheel /export/packages/freebsd-base/head/aarch64
install_dir 755 root wheel /export/packages/freebsd-base/head/amd64
install_dir 755 root wheel /export/packages/freebsd-pkgrepo
install_dir 755 root wheel /export/packages/freebsd-pkgrepo/14.1
install_dir 755 root wheel /export/packages/freebsd-pkgrepo/14.1/aarch64
install_dir 755 root wheel /export/packages/freebsd-pkgrepo/14.1/amd64
install_dir 755 root wheel /export/packages/freebsd-pkgrepo/14.1/armv7
install_dir 755 root wheel /export/packages/freebsd-pkgrepo/head
install_dir 755 root wheel /export/packages/freebsd-pkgrepo/head/aarch64
install_dir 755 root wheel /export/packages/freebsd-pkgrepo/head/amd64
install_dir 755 root wheel /export/packages/archlinux

install_dir 755 root wheel /export/sources/freebsd-ports
install_dir 755 root wheel /export/sources/arch-pkgbuilds

install_dir 700 guy guy /home/guy/share
install_dir 700 guy guy /export/guy_share

install_file 640 root wheel /etc/exports

install_file 644 root wheel /etc/rc.conf

install_dir 755 root wheel /usr/local/db

install_dir 755 root wheel /etc/local
install_symlink ../../etc/local /usr/local/etc

install_dir 755 root wheel /var/cache/xdg
install_dir 700 root wheel /var/cache/xdg/root
install_dir 755 root wheel /var/db/xdg
install_dir 700 root wheel /var/db/xdg/root

install_dir 700 guy guy /var/cache/xdg/guy
install_dir 700 guy guy /var/db/xdg/guy

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

install_dir 755 _dhcp _dhcp /var/db/dhcpcd
install_file 644 root _dhcp /var/db/dhcpcd/duid
install_file 600 root _dhcp /var/db/dhcpcd/secret
install_file 644 root wheel /etc/local/dhcpcd.conf

install_file 644 root wheel /etc/local/doas.conf

install_dir 755 root wheel /etc/local/rsync
install_file 600 root wheel /etc/local/rsync/rsyncd.secrets
install_file 644 root wheel /etc/local/rsync/rsyncd.conf

install_file 644 root wheel /etc/local/gitconfig

install_dir 755 guy guy /home/guy/config/git
install_file 644 guy guy /home/guy/config/git/config

install_dir 755 guy guy /home/guy/repos_docs
install_dir 755 guy guy /home/guy/repos_external_projects
install_dir 755 guy guy /home/guy/repos_ocr
install_dir 755 guy guy /home/guy/repos_problems
install_dir 755 guy guy /home/guy/repos_projects
install_dir 755 guy guy /home/guy/repos_proofing
install_dir 755 guy guy /home/guy/repos_tests
install_dir 755 guy guy /home/guy/repos_todo_docs
install_dir 755 guy guy /home/guy/repos_todo_external_projects
install_dir 755 guy guy /home/guy/repos_todo_projects

install_file 644 root wheel /etc/local/gitup.conf

install_dir 755 root wheel /var/db/samba
install_dir 700 root wheel /var/db/samba/private
install_file 600 root wheel /var/db/samba/private/passdb.tdb.dump
install_file 644 root wheel /etc/local/smb.conf

install_dir 755 guy guy /home/guy/website

install_dir 755 guy guy /home/guy/uploads

install_dir 755 root wheel /etc/local/nginx
install_file 644 root wheel /etc/local/nginx/mime.types

install_dir 755 guy guy /var/tmp/guy/nginx
install_dir 755 guy guy /var/log/guy/nginx
install_file 600 guy guy /etc/local/nginx/htpasswd_guy
install_file 644 guy guy /etc/local/nginx/nginx_guy.conf

install_dir 755 root wheel /usr/local/db/fontconfig
install_dir 755 root wheel /etc/local/fonts
install_file 644 root wheel /etc/local/fonts/local.conf
