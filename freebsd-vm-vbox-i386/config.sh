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
install -l s /usr/share/zoneinfo/Asia/Jerusalem "${DESTDIR}"/etc/localtime || exit 1

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

install -d -m 700 -o guy -g guy "${DESTDIR}"/home/guy || exit 1
install -d -m 755 -o guy -g guy "${DESTDIR}"/home/guy/misc || exit 1
install -d -m 755 -o guy -g guy "${DESTDIR}"/home/guy/projects || exit 1
install -d -m 755 -o guy -g guy "${DESTDIR}"/home/guy/remove || exit 1
install -d -m 755 -o guy -g guy "${DESTDIR}"/home/guy/sync || exit 1

install -d -m 755 -o guy -g guy "${DESTDIR}"/home/guy/config || exit 1

install -d -m 755 -o root -g wheel "${DESTDIR}"/var/xdg-cache || exit 1
install -d -m 700 -o guy -g guy "${DESTDIR}"/var/xdg-cache/guy || exit 1

install -d -m 1777 -o root -g wheel "${DESTDIR}"/home/public || exit 1
install -d -m 1777 -o root -g wheel "${DESTDIR}"/home/shares || exit 1
install -d -m 0700 -o guy -g guy "${DESTDIR}"/home/shares/guy || exit 1

install -c -m 640 -o root -g wheel tree/root/dot.profile "${DESTDIR}"/root/.profile || exit 1
install -c -m 640 -o root -g wheel tree/root/dot.shrc "${DESTDIR}"/root/.shrc || exit 1
install -l h "${DESTDIR}"/root/.profile "${DESTDIR}"/.profile || exit 1
install -c -m 644 -o root -g wheel tree/etc/skel/dot.profile "${DESTDIR}"/etc/skel/dot.profile || exit 1
install -c -m 644 -o root -g wheel tree/etc/skel/dot.shrc "${DESTDIR}"/etc/skel/dot.shrc || exit 1
install -c -m 644 -o guy -g guy tree/home/guy/dot.profile "${DESTDIR}"/home/guy/.profile || exit 1
install -c -m 644 -o guy -g guy tree/home/guy/dot.shrc "${DESTDIR}"/home/guy/.shrc || exit 1

install -c -m 640 -o root -g wheel tree/root/dot.cshrc "${DESTDIR}"/root/.cshrc || exit 1
install -c -m 640 -o root -g wheel tree/root/dot.login "${DESTDIR}"/root/.login || exit 1
install -l h "${DESTDIR}"/root/.cshrc "${DESTDIR}"/.cshrc || exit 1
install -c -m 644 -o root -g wheel tree/etc/skel/dot.cshrc "${DESTDIR}"/etc/skel/dot.cshrc || exit 1
install -c -m 644 -o root -g wheel tree/etc/skel/dot.login "${DESTDIR}"/etc/skel/dot.login || exit 1
install -c -m 644 -o guy -g guy tree/home/guy/dot.cshrc "${DESTDIR}"/home/guy/.cshrc || exit 1
install -c -m 644 -o guy -g guy tree/home/guy/dot.login "${DESTDIR}"/home/guy/.login || exit 1

install -c -m 444 -o root -g wheel tree/boot/device.hints "${DESTDIR}"/boot/device.hints || exit 1

install -c -m 644 -o root -g wheel tree/boot/loader.conf "${DESTDIR}"/boot/loader.conf || exit 1

install -c -m 644 -o root -g wheel tree/etc/hostid "${DESTDIR}"/etc/hostid || exit 1

install -c -m 644 -o root -g wheel tree/etc/devfs.conf "${DESTDIR}"/etc/devfs.conf || exit 1
install -c -m 644 -o root -g wheel tree/etc/devfs.rules "${DESTDIR}"/etc/devfs.rules || exit 1

install -c -m 644 -o root -g wheel tree/etc/sysctl.conf "${DESTDIR}"/etc/sysctl.conf || exit 1

install -c -m 644 -o root -g wheel tree/etc/fstab "${DESTDIR}"/etc/fstab || exit 1

install -c -m 644 -o root -g wheel tree/etc/ttys "${DESTDIR}"/etc/ttys || exit 1

install -c -m 644 -o root -g wheel tree/etc/hosts "${DESTDIR}"/etc/hosts || exit 1

install -l s /var/run/resolv.conf "${DESTDIR}"/etc/resolv.conf || exit 1

install -c -m 644 -o root -g wheel tree/etc/nsswitch.conf "${DESTDIR}"/etc/nsswitch.conf || exit 1
install -c -m 644 -o root -g wheel tree/etc/host.conf "${DESTDIR}"/etc/host.conf || exit 1

install -d -m 755 -o root -g wheel "${DESTDIR}"/etc/ssl/certs || exit 1
install -d -m 700 -o root -g wheel "${DESTDIR}"/etc/ssl/private || exit 1

install -c -m 640 -o root -g wheel tree/root/dot.init.ee "${DESTDIR}"/root/.init.ee || exit 1
install -c -m 644 -o guy -g guy tree/home/guy/dot.init.ee "${DESTDIR}"/home/guy/.init.ee || exit 1

install -c -m 644 -o root -g wheel tree/etc/motd "${DESTDIR}"/etc/motd || exit 1

install -c -m 644 -o root -g wheel tree/etc/mergemaster.rc "${DESTDIR}"/etc/mergemaster.rc || exit 1

install -c -m 644 -o root -g wheel tree/etc/make.conf "${DESTDIR}"/etc/make.conf || exit 1
install -c -m 644 -o root -g wheel tree/etc/src.conf "${DESTDIR}"/etc/src.conf || exit 1

install -c -m 640 -o root -g wheel tree/etc/dhclient.conf "${DESTDIR}"/etc/dhclient.conf || exit 1

install -c -m 644 -o root -g wheel tree/etc/ntp.conf "${DESTDIR}"/etc/ntp.conf || exit 1

install -c -m 644 -o root -g wheel tree/etc/syslog.conf "${DESTDIR}"/etc/syslog.conf || exit 1
install -c -m 644 -o root -g wheel tree/etc/newsyslog.conf "${DESTDIR}"/etc/newsyslog.conf || exit 1

install -c -m 644 -o root -g wheel tree/etc/crontab "${DESTDIR}"/etc/crontab || exit 1

install -c -m 644 -o root -g wheel tree/etc/ssh/ssh_known_hosts "${DESTDIR}"/etc/ssh/ssh_known_hosts || exit 1
install -c -m 644 -o root -g wheel tree/etc/ssh/ssh_config "${DESTDIR}"/etc/ssh/ssh_config || exit 1

install -d -m 700 -o guy -g guy "${DESTDIR}"/home/guy/.ssh || exit 1
install -c -m 600 -o guy -g guy tree/home/guy/dot.ssh/id_rsa "${DESTDIR}"/home/guy/.ssh/id_rsa || exit 1

install -c -m 600 -o root -g wheel tree/etc/ssh/ssh_host_ed25519_key "${DESTDIR}"/etc/ssh/ssh_host_ed25519_key || exit 1
install -c -m 644 -o root -g wheel tree/etc/ssh/ssh_host_ed25519_key.pub "${DESTDIR}"/etc/ssh/ssh_host_ed25519_key.pub || exit 1
install -c -m 600 -o root -g wheel tree/etc/ssh/ssh_host_rsa_key "${DESTDIR}"/etc/ssh/ssh_host_rsa_key || exit 1
install -c -m 644 -o root -g wheel tree/etc/ssh/ssh_host_rsa_key.pub "${DESTDIR}"/etc/ssh/ssh_host_rsa_key.pub || exit 1
install -c -m 640 -o root -g wheel tree/etc/ssh/sshd_config "${DESTDIR}"/etc/ssh/sshd_config || exit 1

install -d -m 700 -o guy -g guy "${DESTDIR}"/home/guy/.ssh || exit 1
install -c -m 600 -o guy -g guy tree/home/guy/dot.ssh/authorized_keys "${DESTDIR}"/home/guy/.ssh/authorized_keys || exit 1

install -c -m 640 -o root -g wheel tree/etc/exports "${DESTDIR}"/etc/exports || exit 1

install -c -m 644 -o root -g wheel tree/etc/rc.conf "${DESTDIR}"/etc/rc.conf || exit 1

install -d -m 755 -o root -g wheel "${DESTDIR}"/etc/local || exit 1
install -l s /etc/local "${DESTDIR}"/usr/local/etc || exit 1

install -d -m 755 -o root -g wheel "${DESTDIR}"/usr/local/db || exit 1

install -d -m 755 -o root -g wheel "${DESTDIR}"/usr/local/db/pkg || exit 1
install -c -m 644 -o root -g wheel tree/etc/local/pkg.conf "${DESTDIR}"/etc/local/pkg.conf || exit 1

install -d -m 755 -o root -g wheel "${DESTDIR}"/usr/local/db/ports || exit 1

install -c -m 644 -o root -g wheel tree/etc/local/portmaster.rc "${DESTDIR}"/etc/local/portmaster.rc || exit 1

install -c -m 644 -o root -g wheel tree/etc/local/nanorc "${DESTDIR}"/etc/local/nanorc || exit 1

install -c -m 640 -o root -g wheel tree/root/dot.zshrc "${DESTDIR}"/root/.zshrc || exit 1
install -c -m 644 -o guy -g guy tree/home/guy/dot.zshrc "${DESTDIR}"/home/guy/.zshrc || exit 1

install -c -m 644 -o guy -g guy tree/home/guy/dot.hgrc "${DESTDIR}"/home/guy/.hgrc || exit 1

install -d -m 755 -o root -g wheel "${DESTDIR}"/var/db/samba || exit 1
install -d -m 755 -o root -g wheel "${DESTDIR}"/var/db/samba/private || exit 1
install -c -m 600 -o root -g wheel tree/var/db/samba/private/passdb.tdb "${DESTDIR}"/var/db/samba/private/passdb.tdb || exit 1
install -c -m 644 -o root -g wheel tree/etc/local/smb.conf "${DESTDIR}"/etc/local/smb.conf || exit 1

install -c -m 644 -o root -g wheel tree/etc/local/dhcpcd.duid "${DESTDIR}"/etc/local/dhcpcd.duid || exit 1
install -c -m 400 -o root -g wheel tree/etc/local/dhcpcd.secret "${DESTDIR}"/etc/local/dhcpcd.secret || exit 1
install -c -m 644 -o root -g wheel tree/etc/local/dhcpcd.conf "${DESTDIR}"/etc/local/dhcpcd.conf || exit 1

install -d -m 755 -o root -g wheel "${DESTDIR}"/etc/local/polkit-1 || exit 1
install -d -m 755 -o root -g wheel "${DESTDIR}"/etc/local/polkit-1/localauthority || exit 1
install -d -m 755 -o root -g wheel "${DESTDIR}"/etc/local/polkit-1/localauthority/50-local.d || exit 1
install -c -m 644 -o root -g wheel tree/etc/local/polkit-1/localauthority/50-local.d/org.freedesktop.consolekit.pkla "${DESTDIR}"/etc/local/polkit-1/localauthority/50-local.d/org.freedesktop.consolekit.pkla || exit 1

install -d -m 755 -o root -g wheel "${DESTDIR}"/var/db/dbus || exit 1
install -c -m 644 -o root -g wheel tree/etc/local/machine-id "${DESTDIR}"/etc/local/machine-id || exit 1
install -l s /etc/local/machine-id "${DESTDIR}"/var/db/dbus/machine-id || exit 1

install -d -m 700 -o guy -g guy "${DESTDIR}"/var/xdg-cache/guy/thumbnails || exit 1
install -l s /var/xdg-cache/guy/thumbnails "${DESTDIR}"/home/guy/.thumbnails || exit 1
chown -h guy "${DESTDIR}"/home/guy/.thumbnails || exit 1

install -d -m 755 -o root -g wheel "${DESTDIR}"/usr/local/db/fontconfig || exit 1
install -d -m 755 -o root -g wheel "${DESTDIR}"/etc/local/fonts || exit 1
install -c -m 644 -o root -g wheel tree/etc/local/fonts/local.conf "${DESTDIR}"/etc/local/fonts/local.conf || exit 1

install -c -m 755 -o guy -g guy tree/home/guy/dot.xprofile "${DESTDIR}"/home/guy/.xprofile || exit 1
install -c -m 755 -o guy -g guy tree/home/guy/dot.xinitrc "${DESTDIR}"/home/guy/.xinitrc || exit 1
install -c -m 644 -o guy -g guy tree/home/guy/dot.xserverrc "${DESTDIR}"/home/guy/.xserverrc || exit 1
install -c -m 644 -o guy -g guy tree/home/guy/dot.Xresources "${DESTDIR}"/home/guy/.Xresources || exit 1

install -d -m 755 -o root -g wheel "${DESTDIR}"/etc/local/xdg || exit 1
install -d -m 755 -o root -g wheel "${DESTDIR}"/etc/local/xdg/menus || exit 1
install -c -m 644 -o root -g wheel tree/etc/local/xdg/menus/all-applications.menu "${DESTDIR}"/etc/local/xdg/menus/all-applications.menu || exit 1

install -d -m 755 -o guy -g guy "${DESTDIR}"/home/guy/config/gtk-2.0 || exit 1
install -c -m 644 -o guy -g guy tree/home/guy/config/gtk-2.0/gtkfilechooser.ini "${DESTDIR}"/home/guy/config/gtk-2.0/gtkfilechooser.ini || exit 1
install -c -m 644 -o guy -g guy tree/home/guy/config/gtk-2.0/gtkrc "${DESTDIR}"/home/guy/config/gtk-2.0/gtkrc || exit 1

install -d -m 755 -o guy -g guy "${DESTDIR}"/home/guy/config/gtk-3.0 || exit 1
install -c -m 644 -o guy -g guy tree/home/guy/config/gtk-3.0/settings.ini "${DESTDIR}"/home/guy/config/gtk-3.0/settings.ini || exit 1
install -c -m 644 -o guy -g guy tree/home/guy/config/gtk-3.0/bookmarks "${DESTDIR}"/home/guy/config/gtk-3.0/bookmarks || exit 1

install -d -m 755 -o guy -g guy "${DESTDIR}"/home/guy/config/openbox || exit 1
install -c -m 644 -o guy -g guy tree/home/guy/config/openbox/menu.xml "${DESTDIR}"/home/guy/config/openbox/menu.xml || exit 1
install -c -m 644 -o guy -g guy tree/home/guy/config/openbox/rc.xml "${DESTDIR}"/home/guy/config/openbox/rc.xml || exit 1

install -d -m 755 -o guy -g guy "${DESTDIR}"/home/guy/config/tint2 || exit 1
install -c -m 644 -o guy -g guy tree/home/guy/config/tint2/tint2rc "${DESTDIR}"/home/guy/config/tint2/tint2rc || exit 1

install -c -m 644 -o guy -g guy tree/home/guy/dot.gmrunrc "${DESTDIR}"/home/guy/.gmrunrc || exit 1

install -d -m 755 -o guy -g guy "${DESTDIR}"/home/guy/config/leafpad || exit 1
install -c -m 644 -o guy -g guy tree/home/guy/config/leafpad/leafpadrc "${DESTDIR}"/home/guy/config/leafpad/leafpadrc || exit 1
