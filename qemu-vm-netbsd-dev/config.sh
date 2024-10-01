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
if [ "${uname_p}" != "x86_64" ]; then
  case ${uname_p} in
    x86_64) ;;
    *)
      echo "config.sh: endian mismatch between host arch and target arch or unsupported host arch." 1>&2
      exit 1
      ;;
  esac
fi


# -- set up params --
DESTDIR=${1%/}


# -- functions --
install_dir()
{
  mode=$1
  owner=$2
  group=$3
  path=$4
  
  if [ -z "${echo_mode}" ]; then
    install -d -m ${mode} -o ${owner} -g ${group} "${DESTDIR}"${path} || exit 1
  else
    echo install -d -m ${mode} -o ${owner} -g ${group} ${DESTDIR}${path}
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
    install -c -m ${mode} -o ${owner} -g ${group} tree${src} "${DESTDIR}"${dst} || exit 1
  else
    echo install -c -m ${mode} -o ${owner} -g ${group} tree${src} ${DESTDIR}${dst}
  fi
}

install_empty_file()
{
  mode=$1
  owner=$2
  group=$3
  dst=$4
  
  if [ -z "${echo_mode}" ]; then
    install -c -m ${mode} -o ${owner} -g ${group} /dev/null "${DESTDIR}"${dst} || exit 1
  else
    echo install -c -m ${mode} -o ${owner} -g ${group} /dev/null ${DESTDIR}${dst}
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
install_file 644 root wheel /etc/usermgmt.conf

install_file 644 root wheel /etc/group

install_file 600 root wheel /etc/master.passwd /etc/master.passwd.new
pwd_mkdb_file /etc /etc/master.passwd.new

install_dir 755 root wheel /var/cache

install_dir 700 guy users /home/guy
install_dir 755 guy users /home/guy/misc
install_dir 755 guy users /home/guy/projects
install_dir 755 guy users /home/guy/remove

install_file 644 root wheel /boot.cfg

install_file 644 root wheel /etc/ttys

install_file 644 root wheel /etc/myname

install_file 644 root wheel /etc/hosts

install_symlink ../var/run/resolv.conf /etc/resolv.conf
# chown_symlink root wheel /etc/resolv.conf

install_file 644 root wheel /etc/resolvconf.conf

install_file 644 root wheel /etc/nsswitch.conf

install_file 644 root wheel /etc/motd

install_file 644 root wheel /etc/mk.conf

install_file 640 root wheel /root/.profile
install_file 640 root wheel /root/.shrc
install_hardlink /root/.profile /.profile

install_file 644 guy users /home/guy/.profile
install_file 644 guy users /home/guy/.shrc

install_file 640 root wheel /etc/syslog.conf

install_file 640 root wheel /etc/newsyslog.conf

install_file 600 root wheel /etc/crontab

install_file 644 root wheel /var/db/dhcpcd/duid
install_file 600 root wheel /var/db/dhcpcd/secret
install_file 644 root wheel /etc/dhcpcd.conf /etc/dhcpcd.conf

install_file 644 root wheel /etc/ssh/ssh_known_hosts
install_file 644 root wheel /etc/ssh/ssh_config

install_dir 700 guy users /home/guy/.ssh
install_file 600 guy users /home/guy/.ssh/id_ed25519
install_file 644 guy users /home/guy/.ssh/id_ed25519.pub
install_file 600 guy users /home/guy/.ssh/id_rsa
install_file 644 guy users /home/guy/.ssh/id_rsa.pub

install_file 600 root wheel /etc/ssh/ssh_host_rsa_key
install_file 644 root wheel /etc/ssh/ssh_host_rsa_key.pub
install_file 600 root wheel /etc/ssh/ssh_host_ed25519_key
install_file 644 root wheel /etc/ssh/ssh_host_ed25519_key.pub
install_file 644 root wheel /etc/ssh/ssh_host_ed25519_key-cert.pub
install_empty_file 600 root wheel /etc/ssh/ssh_host_key
install_empty_file 644 root wheel /etc/ssh/ssh_host_key.pub
install_file 640 root wheel /etc/ssh/sshd_config

install_file 600 guy users /home/guy/.ssh/authorized_keys

install_file 640 root wheel /etc/rc.conf

install_dir 755 root wheel /usr/pkg

install_dir 755 root wheel /etc/pkg
install_symlink ../../etc/pkg /usr/pkg/etc

install_dir 755 root wheel /var/cache/xdg
install_dir 700 root wheel /var/cache/xdg/root
install_dir 755 root wheel /var/db/xdg
install_dir 700 root wheel /var/db/xdg/root

install_dir 700 guy users /var/cache/xdg/guy
install_dir 700 guy users /var/db/xdg/guy

install_dir 755 guy users /home/guy/config

install_file 644 root wheel /etc/pkg/nanorc

install_file 640 root wheel /root/.zshrc

install_file 644 guy users /home/guy/.zshrc
