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
if [ "${uname_p}" != "amd64" ]; then
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

install_dir 700 guy guy /var/tmp/guy

install_dir 700 guy guy /home/guy
install_dir 755 guy guy /home/guy/external_projects
install_dir 755 guy guy /home/guy/github
install_dir 755 guy guy /home/guy/misc
install_dir 755 guy guy /home/guy/misc/fbsd-src
install_dir 755 guy guy /home/guy/projects
install_dir 755 guy guy /home/guy/remove
install_dir 755 guy guy /home/guy/tests

install_dir 755 root wheel /compat

install_dir 755 root wheel /compat/linux
install_dir 755 root wheel /compat/linux/proc

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

install_dir 755 root wheel /usr/wrkdir_tmp

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

install_dir 755 root wheel /jails/ports-builder-fbsd

install_file 644 root wheel /etc/jail.conf

install_dir 755 root wheel /export/obj

install_dir 755 root wheel /export/src

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

install_dir 755 root wheel /etc/local/xdg

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

install_file 644 root wheel /etc/local/gitconfig

install_dir 755 guy guy /home/guy/config/git
install_file 644 guy guy /home/guy/config/git/config

install_file 644 guy guy /home/guy/.hgrc

install_dir 755 root wheel /usr/local/db/fontconfig
install_dir 755 root wheel /etc/local/fonts
install_file 644 root wheel /etc/local/fonts/local.conf

install_dir 755 root wheel /var/lib/dbus
install_symlink ../../../etc/machine-id /var/lib/dbus/machine-id

install_dir 755 guy guy /var/cache/xdg/guy/thumbnails
install_symlink ../../var/cache/xdg/guy/thumbnails /home/guy/.thumbnails
chown_symlink guy guy /home/guy/.thumbnails

install_file 644 guy guy /home/guy/.xprofile
install_file 644 guy guy /home/guy/.Xresources
install_hardlink /home/guy/.Xresources /home/guy/.Xdefaults
install_file 755 guy guy /home/guy/.xinitrc

install_file 644 guy guy /home/guy/config/picom.conf

install_dir 755 guy guy /home/guy/config/gtk-3.0
install_file 644 guy guy /home/guy/config/gtk-3.0/settings.ini
install_file 644 guy guy /home/guy/config/gtk-3.0/bookmarks

install_dir 755 guy guy /home/guy/config/qt5ct
install_file 644 guy guy /home/guy/config/qt5ct/qt5ct.conf

install_dir 755 guy guy /home/guy/config/qt6ct
install_file 644 guy guy /home/guy/config/qt6ct/qt6ct.conf

install_file 755 guy guy /home/guy/config/import_gsettings.sh

install_dir 755 root wheel /etc/local/xdg/menus
install_file 644 root wheel /etc/local/xdg/menus/all-applications.menu

install_dir 755 guy guy /home/guy/config/openbox
install_file 755 guy guy /home/guy/config/openbox/autostart
install_file 644 guy guy /home/guy/config/openbox/menu.xml
install_file 644 guy guy /home/guy/config/openbox/rc.xml

install_dir 755 guy guy /home/guy/config/tint2
install_file 644 guy guy /home/guy/config/tint2/tint2rc

install_file 644 guy guy /home/guy/config/wprofile

install_file 644 guy guy /home/guy/config/wayfire.ini
install_file 644 guy guy /home/guy/config/wf-shell.ini

install_dir 755 guy guy /home/guy/config/labwc
install_file 755 guy guy /home/guy/config/labwc/autostart
install_file 644 guy guy /home/guy/config/labwc/menu.xml
install_file 644 guy guy /home/guy/config/labwc/rc.xml

install_dir 755 guy guy /home/guy/config/wayvnc
install_file 644 guy guy /home/guy/config/wayvnc/config

install_dir 755 guy guy /home/guy/config/terminator
install_file 644 guy guy /home/guy/config/terminator/config

install_file 644 guy guy /home/guy/.gmrunrc

install_dir 755 guy guy /home/guy/config/pcmanfm-qt
install_dir 755 guy guy /home/guy/config/pcmanfm-qt/default
install_file 644 guy guy /home/guy/config/pcmanfm-qt/default/settings.conf

install_dir 755 guy guy /home/guy/config/featherpad
install_file 644 guy guy /home/guy/config/featherpad/fp.conf

install_dir 755 guy guy /home/guy/config/geany
install_file 644 guy guy /home/guy/config/geany/geany.conf
