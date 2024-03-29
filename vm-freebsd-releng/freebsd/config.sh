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


# -- set up params --
DESTDIR=${1%/}
TARGET_ARCH=amd64


#
install -l s ../usr/share/zoneinfo/Asia/Jerusalem "${DESTDIR}"/etc/localtime || exit 1

install -c -m 644 -o root -g wheel tree/etc/login.conf "${DESTDIR}"/etc/login.conf || exit 1
if [ -z "${DESTDIR}" ]; then
  cap_mkdb /etc/login.conf || exit 1
else
  if [ "${TARGET_ARCH}" = "aarch64" -o "${TARGET_ARCH}" = "amd64" -o "${TARGET_ARCH}" = "armv7" ]; then
    cap_mkdb -l "${DESTDIR}"/etc/login.conf || exit 1
  else
    printf "script is missing login.conf endian for ${TARGET_ARCH}\n" 1>&2
    exit 1
  fi
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

install -c -m 444 -o root -g wheel tree/boot/device.hints "${DESTDIR}"/boot/device.hints || exit 1

install -c -m 644 -o root -g wheel tree/boot/loader.conf "${DESTDIR}"/boot/loader.conf || exit 1

install -c -m 644 -o root -g wheel tree/etc/devfs.conf "${DESTDIR}"/etc/devfs.conf || exit 1
install -c -m 644 -o root -g wheel tree/etc/devfs.rules "${DESTDIR}"/etc/devfs.rules || exit 1

install -c -m 644 -o root -g wheel tree/etc/rc.conf.lan0 "${DESTDIR}"/etc/rc.conf.lan0 || exit 1

install -c -m 644 -o root -g wheel tree/etc/hostid "${DESTDIR}"/etc/hostid || exit 1

install -c -m 644 -o root -g wheel tree/etc/sysctl.conf "${DESTDIR}"/etc/sysctl.conf || exit 1

install -c -m 644 -o root -g wheel tree/etc/ttys "${DESTDIR}"/etc/ttys || exit 1

install -c -m 644 -o root -g wheel tree/etc/hosts "${DESTDIR}"/etc/hosts || exit 1

install -l s ../var/run/resolv.conf "${DESTDIR}"/etc/resolv.conf || exit 1

install -c -m 644 -o root -g wheel tree/etc/nsswitch.conf "${DESTDIR}"/etc/nsswitch.conf || exit 1

install -d -m 755 -o root -g wheel "${DESTDIR}"/etc/ssl/certs || exit 1
install -d -m 700 -o root -g wheel "${DESTDIR}"/etc/ssl/private || exit 1

install -c -m 644 -o root -g wheel tree/etc/motd "${DESTDIR}"/etc/motd || exit 1

install -c -m 644 -o root -g wheel tree/etc/fstab "${DESTDIR}"/etc/fstab || exit 1

install -c -m 640 -o root -g wheel tree/etc/exports "${DESTDIR}"/etc/exports || exit 1

install -c -m 640 -o root -g wheel tree/root/.profile "${DESTDIR}"/root/.profile || exit 1
install -c -m 640 -o root -g wheel tree/root/.shrc "${DESTDIR}"/root/.shrc || exit 1
install -l h "${DESTDIR}"/root/.profile "${DESTDIR}"/.profile || exit 1
install -c -m 644 -o guy -g guy tree/home/guy/.profile "${DESTDIR}"/home/guy/.profile || exit 1
install -c -m 644 -o guy -g guy tree/home/guy/.shrc "${DESTDIR}"/home/guy/.shrc || exit 1

install -c -m 640 -o root -g wheel tree/root/.cshrc "${DESTDIR}"/root/.cshrc || exit 1
install -l h "${DESTDIR}"/root/.cshrc "${DESTDIR}"/.cshrc || exit 1
install -c -m 644 -o guy -g guy tree/home/guy/.cshrc "${DESTDIR}"/home/guy/.cshrc || exit 1

install -c -m 644 -o root -g wheel tree/etc/mergemaster.rc "${DESTDIR}"/etc/mergemaster.rc || exit 1

install -c -m 640 -o root -g wheel tree/etc/dhclient.conf "${DESTDIR}"/etc/dhclient.conf || exit 1

install -c -m 644 -o root -g wheel tree/etc/syslog.conf "${DESTDIR}"/etc/syslog.conf || exit 1
install -c -m 644 -o root -g wheel tree/etc/newsyslog.conf "${DESTDIR}"/etc/newsyslog.conf || exit 1

install -c -m 644 -o root -g wheel tree/etc/crontab "${DESTDIR}"/etc/crontab || exit 1
install -c -m 644 -o root -g wheel tree/etc/cron.d/at "${DESTDIR}"/etc/cron.d/at || exit 1

install -c -m 644 -o root -g wheel tree/etc/ssh/ssh_known_hosts "${DESTDIR}"/etc/ssh/ssh_known_hosts || exit 1
install -c -m 644 -o root -g wheel tree/etc/ssh/ssh_config "${DESTDIR}"/etc/ssh/ssh_config || exit 1

install -d -m 700 -o guy -g guy "${DESTDIR}"/home/guy/.ssh || exit 1
install -c -m 600 -o guy -g guy tree/home/guy/.ssh/id_ed25519 "${DESTDIR}"/home/guy/.ssh/id_ed25519 || exit 1
install -c -m 644 -o guy -g guy tree/home/guy/.ssh/id_ed25519.pub "${DESTDIR}"/home/guy/.ssh/id_ed25519.pub || exit 1
install -c -m 600 -o guy -g guy tree/home/guy/.ssh/id_rsa "${DESTDIR}"/home/guy/.ssh/id_rsa || exit 1
install -c -m 644 -o guy -g guy tree/home/guy/.ssh/id_rsa.pub "${DESTDIR}"/home/guy/.ssh/id_rsa.pub || exit 1

install -c -m 600 -o root -g wheel tree/etc/ssh/ssh_host_ed25519_key "${DESTDIR}"/etc/ssh/ssh_host_ed25519_key || exit 1
install -c -m 644 -o root -g wheel tree/etc/ssh/ssh_host_ed25519_key.pub "${DESTDIR}"/etc/ssh/ssh_host_ed25519_key.pub || exit 1
install -c -m 644 -o root -g wheel tree/etc/ssh/ssh_host_ed25519_key-cert.pub "${DESTDIR}"/etc/ssh/ssh_host_ed25519_key-cert.pub || exit 1
install -c -m 600 -o root -g wheel tree/etc/ssh/ssh_host_rsa_key "${DESTDIR}"/etc/ssh/ssh_host_rsa_key || exit 1
install -c -m 644 -o root -g wheel tree/etc/ssh/ssh_host_rsa_key.pub "${DESTDIR}"/etc/ssh/ssh_host_rsa_key.pub || exit 1
install -c -m 640 -o root -g wheel tree/etc/ssh/sshd_config "${DESTDIR}"/etc/ssh/sshd_config || exit 1

install -c -m 600 -o guy -g guy tree/home/guy/.ssh/authorized_keys "${DESTDIR}"/home/guy/.ssh/authorized_keys || exit 1

install -c -m 644 -o root -g wheel tree/etc/jail.conf "${DESTDIR}"/etc/jail.conf || exit 1

install -c -m 644 -o root -g wheel tree/etc/rc.conf "${DESTDIR}"/etc/rc.conf || exit 1

install -d -m 755 -o root -g wheel "${DESTDIR}"/etc/local || exit 1
install -l s ../../etc/local "${DESTDIR}"/usr/local/etc || exit 1

install -d -m 755 -o root -g wheel "${DESTDIR}"/etc/local/xdg || exit 1

install -d -m 755 -o guy -g guy "${DESTDIR}"/home/guy/config || exit 1

install -c -m 644 -o root -g wheel tree/etc/local/pkg.conf "${DESTDIR}"/etc/local/pkg.conf || exit 1

install -d -m 755 -o root -g wheel "${DESTDIR}"/etc/local/pkg || exit 1
install -d -m 755 -o root -g wheel "${DESTDIR}"/etc/local/pkg/repos || exit 1
install -c -m 644 -o root -g wheel tree/etc/local/pkg/repos/custom.conf "${DESTDIR}"/etc/local/pkg/repos/custom.conf || exit 1
install -c -m 644 -o root -g wheel tree/etc/local/pkg/repos/FreeBSD.conf "${DESTDIR}"/etc/local/pkg/repos/FreeBSD.conf || exit 1

install -c -m 644 -o root -g wheel tree/etc/local/nanorc "${DESTDIR}"/etc/local/nanorc || exit 1

install -c -m 640 -o root -g wheel tree/root/.zshrc "${DESTDIR}"/root/.zshrc || exit 1
install -c -m 644 -o guy -g guy tree/home/guy/.zshrc "${DESTDIR}"/home/guy/.zshrc || exit 1

install -c -m 644 -o root -g wheel tree/etc/local/tmux.conf "${DESTDIR}"/etc/local/tmux.conf || exit 1

install -c -m 644 -o guy -g guy tree/home/guy/.hgrc "${DESTDIR}"/home/guy/.hgrc || exit 1

install -d -m 755 -o root -g wheel "${DESTDIR}"/var/db/dhcpcd || exit 1
install -c -m 644 -o root -g wheel tree/etc/local/dhcpcd.duid.backup "${DESTDIR}"/etc/local/dhcpcd.duid.backup || exit 1
install -c -m 644 -o root -g wheel "${DESTDIR}"/etc/local/dhcpcd.duid.backup "${DESTDIR}"/var/db/dhcpcd/duid || exit 1
install -c -m 600 -o root -g wheel tree/etc/local/dhcpcd.secret.backup "${DESTDIR}"/etc/local/dhcpcd.secret.backup || exit 1
install -c -m 600 -o root -g wheel "${DESTDIR}"/etc/local/dhcpcd.secret.backup "${DESTDIR}"/var/db/dhcpcd/secret || exit 1
install -c -m 644 -o root -g wheel tree/etc/local/dhcpcd.conf "${DESTDIR}"/etc/local/dhcpcd.conf || exit 1

install -c -m 644 -o root -g wheel tree/etc/local/gitconfig "${DESTDIR}"/etc/local/gitconfig || exit 1

install -d -m 755 -o guy -g guy "${DESTDIR}"/home/guy/config/git || exit 1
install -c -m 644 -o guy -g guy tree/home/guy/config/git/config "${DESTDIR}"/home/guy/config/git/config || exit 1

install -c -m 644 -o root -g wheel tree/etc/local/machine-id "${DESTDIR}"/etc/local/machine-id || exit 1
install -d -m 755 -o root -g wheel "${DESTDIR}"/var/lib/dbus || exit 1
install -l s ../../../etc/local/machine-id "${DESTDIR}"/var/lib/dbus/machine-id || exit 1

install -d -m 755 -o root -g wheel "${DESTDIR}"/etc/local/fonts || exit 1
install -c -m 644 -o root -g wheel tree/etc/local/fonts/local.conf "${DESTDIR}"/etc/local/fonts/local.conf || exit 1

install -c -m 644 -o guy -g guy tree/home/guy/.xprofile "${DESTDIR}"/home/guy/.xprofile || exit 1
install -c -m 644 -o guy -g guy tree/home/guy/.Xresources "${DESTDIR}"/home/guy/.Xresources || exit 1
install -c -m 644 -o guy -g guy tree/home/guy/.xserverrc "${DESTDIR}"/home/guy/.xserverrc || exit 1
install -c -m 755 -o guy -g guy tree/home/guy/.xinitrc "${DESTDIR}"/home/guy/.xinitrc || exit 1

install -d -m 755 -o guy -g guy "${DESTDIR}"/home/guy/config/gtk-2.0 || exit 1
install -c -m 644 -o guy -g guy tree/home/guy/config/gtk-2.0/gtkfilechooser.ini "${DESTDIR}"/home/guy/config/gtk-2.0/gtkfilechooser.ini || exit 1
install -c -m 644 -o guy -g guy tree/home/guy/config/gtk-2.0/gtkrc "${DESTDIR}"/home/guy/config/gtk-2.0/gtkrc || exit 1

install -d -m 755 -o guy -g guy "${DESTDIR}"/home/guy/config/gtk-3.0 || exit 1
install -c -m 644 -o guy -g guy tree/home/guy/config/gtk-3.0/settings.ini "${DESTDIR}"/home/guy/config/gtk-3.0/settings.ini || exit 1
install -c -m 644 -o guy -g guy tree/home/guy/config/gtk-3.0/bookmarks "${DESTDIR}"/home/guy/config/gtk-3.0/bookmarks || exit 1

install -d -m 755 -o guy -g guy "${DESTDIR}"/home/guy/config/qt5ct || exit 1
install -c -m 644 -o guy -g guy tree/home/guy/config/qt5ct/qt5ct.conf "${DESTDIR}"/home/guy/config/qt5ct/qt5ct.conf || exit 1

install -d -m 755 -o root -g wheel "${DESTDIR}"/etc/local/xdg/menus || exit 1
install -c -m 644 -o root -g wheel tree/etc/local/xdg/menus/all-applications.menu "${DESTDIR}"/etc/local/xdg/menus/all-applications.menu || exit 1

install -d -m 755 -o guy -g guy "${DESTDIR}"/home/guy/config/openbox || exit 1
install -c -m 644 -o guy -g guy tree/home/guy/config/openbox/menu.xml "${DESTDIR}"/home/guy/config/openbox/menu.xml || exit 1
install -c -m 644 -o guy -g guy tree/home/guy/config/openbox/rc.xml "${DESTDIR}"/home/guy/config/openbox/rc.xml || exit 1

install -d -m 755 -o guy -g guy "${DESTDIR}"/home/guy/config/tint2 || exit 1
install -c -m 644 -o guy -g guy tree/home/guy/config/tint2/tint2rc "${DESTDIR}"/home/guy/config/tint2/tint2rc || exit 1

install -c -m 644 -o guy -g guy tree/home/guy/.gmrunrc "${DESTDIR}"/home/guy/.gmrunrc || exit 1

install -d -m 755 -o guy -g guy "${DESTDIR}"/home/guy/config/pcmanfm-qt || exit 1
install -d -m 755 -o guy -g guy "${DESTDIR}"/home/guy/config/pcmanfm-qt/default || exit 1
install -c -m 644 -o guy -g guy tree/home/guy/config/pcmanfm-qt/default/settings.conf "${DESTDIR}"/home/guy/config/pcmanfm-qt/default/settings.conf || exit 1

install -d -m 755 -o guy -g guy "${DESTDIR}"/home/guy/config/featherpad || exit 1
install -c -m 644 -o guy -g guy tree/home/guy/config/featherpad/fp.conf "${DESTDIR}"/home/guy/config/featherpad/fp.conf || exit 1
