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

install_hardlink()
{
  src=$1
  dst=$2
  
  if [ -z "${echo_mode}" ]; then
    ln -fn "${DESTDIR}"${src} "${DESTDIR}"${dst} || exit 1
  else
    echo ln -fn ${DESTDIR}${src} ${DESTDIR}${dst}
  fi
}

install_symlink()
{
  src=$1
  dst=$2
  
  if [ -z "${echo_mode}" ]; then
    ln -sfn ${src} "${DESTDIR}"${dst} || exit 1
  else
    echo ln -sfn ${src} ${DESTDIR}${dst}
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


#
install_dir 755 root root /etc

install_symlink ../usr/share/zoneinfo/Asia/Jerusalem /etc/localtime

install_file 644 root root /etc/login.defs

install_file 600 root root /etc/gshadow
install_file 644 root root /etc/group

install_file 600 root root /etc/shadow
install_file 644 root root /etc/passwd

install_dir 755 root root /var/cache
install_dir 755 root root /var/lib

install_dir 755 root root /usr

install_dir 755 root root /usr/db

install_dir 750 root root /root

install_dir 700 guy guy /home/guy
install_dir 755 guy guy /home/guy/external_projects
install_dir 755 guy guy /home/guy/github
install_dir 755 guy guy /home/guy/misc
install_dir 755 guy guy /home/guy/projects
install_dir 755 guy guy /home/guy/remove
install_dir 755 guy guy /home/guy/tests

install_dir 755 root root /var/cache/pacman
install_dir 755 root root /usr/db/pacman
install_symlink ../../../var/cache/pacman/sync /usr/db/pacman/sync

install_dir 755 root root /var/cache/xdg
install_dir 700 root root /var/cache/xdg/root
install_dir 755 root root /var/lib/xdg
install_dir 700 root root /var/lib/xdg/root

install_dir 700 guy guy /var/cache/xdg/guy
install_dir 700 guy guy /var/lib/xdg/guy

install_dir 755 root root /etc/xdg

install_dir 755 guy guy /home/guy/config
install_symlink config /home/guy/.config

install_file 644 root root /etc/locale.gen
install_file 644 root root /etc/locale.conf

install_file 644 root root /etc/inputrc

install_symlink ../usr/lib/os-release /etc/os-release

install_dir 755 root root /etc/systemd
install_dir 755 root root /etc/systemd/system
install_dir 755 root root /etc/systemd/system/multi-user.target.wants
install_dir 755 root root /etc/systemd/system/remote-fs.target.wants
install_dir 755 root root /etc/systemd/system/sockets.target.wants

install_dir 755 root root /efi/EFI
install_dir 755 root root /efi/EFI/BOOT
install_file 644 root root /efi/EFI/BOOT/refind.conf

install_dir 755 root root /etc/modprobe.d
install_file 644 root root /etc/modprobe.d/my_blacklist.conf

install_dir 755 root root /etc/udev

install_dir 755 root root /etc/udev/hwdb.d

install_dir 755 root root /etc/udev/rules.d

install_file 644 root root /etc/udev/rules.d/81-network-names.rules

install_dir 755 root root /etc/sysctl.d
install_file 644 root root /etc/sysctl.d/40-ipv6.conf
install_symlink /dev/null /etc/sysctl.d/50-coredump.conf
install_file 644 root root /etc/sysctl.d/99-sysctl.conf

install_dir 755 root root /etc/security

install_file 644 root root /etc/security/limits.conf

install_file 644 root root /etc/hostname

install_file 444 root root /etc/machine-id

install_file 644 root root /etc/hosts

install_symlink ../run/resolv.conf /etc/resolv.conf

install_file 644 root root /etc/resolvconf.conf

install_file 644 root root /etc/nsswitch.conf

install_file 644 root root /etc/fstab

install_symlink /dev/null /etc/systemd/system/systemd-tmpfiles-clean.timer
install_symlink /dev/null /etc/systemd/system/systemd-tmpfiles-clean.service

install_file 644 root root /root/.profile

install_file 644 guy guy /home/guy/.profile

install_file 644 root root /root/.bashrc

install_file 644 guy guy /home/guy/.bashrc

install_dir 755 root root /etc/ssh

install_file 644 root root /etc/ssh/ssh_known_hosts
install_file 644 root root /etc/ssh/ssh_config

install_dir 700 guy guy /home/guy/.ssh
install_file 600 guy guy /home/guy/.ssh/id_ed25519
install_file 644 guy guy /home/guy/.ssh/id_ed25519.pub
install_file 600 guy guy /home/guy/.ssh/id_rsa
install_file 644 guy guy /home/guy/.ssh/id_rsa.pub

install_file 600 root root /etc/ssh/ssh_host_rsa_key
install_file 644 root root /etc/ssh/ssh_host_rsa_key.pub
install_file 600 root root /etc/ssh/ssh_host_ed25519_key
install_file 644 root root /etc/ssh/ssh_host_ed25519_key.pub
install_file 644 root root /etc/ssh/ssh_host_ed25519_key-cert.pub
install_file 640 root root /etc/ssh/sshd_config
install_file 644 root root /etc/systemd/system/sshdgenkeys.service
install_symlink /usr/lib/systemd/system/sshd.service /etc/systemd/system/multi-user.target.wants/sshd.service

install_file 600 guy guy /home/guy/.ssh/authorized_keys

install_dir 700 guy guy /home/guy/share
install_dir 700 guy guy /export/guy_share

install_file 640 root root /etc/exports

install_symlink /usr/lib/systemd/system/nfs-server.service /etc/systemd/system/multi-user.target.wants/nfs-server.service

install_file 644 root root /etc/nanorc

install_file 644 root root /root/.zprofile
install_file 644 root root /root/.zshrc

install_file 644 guy guy /home/guy/.zprofile
install_file 644 guy guy /home/guy/.zshrc

install_file 644 root root /etc/tmux.conf

install_dir 750 root root /var/lib/dhcpcd
install_file 644 root root /var/lib/dhcpcd/duid
install_file 600 root root /var/lib/dhcpcd/secret
install_file 644 root root /etc/dhcpcd.conf

install_symlink /usr/lib/systemd/system/dhcpcd.service /etc/systemd/system/multi-user.target.wants/dhcpcd.service

install_dir 755 guy guy /home/guy/config/git
install_file 644 guy guy /home/guy/config/git/config

install_dir 755 root root /usr/db/fontconfig
install_dir 755 root root /etc/fonts
install_file 644 root root /etc/fonts/local.conf

install_symlink /usr/lib/systemd/system/seatd.service /etc/systemd/system/multi-user.target.wants/seatd.service

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

install_dir 755 root root /etc/xdg/menus
install_file 644 root root /etc/xdg/menus/all-applications.menu

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
