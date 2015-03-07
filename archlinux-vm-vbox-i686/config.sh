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
ln -sfn /usr/share/zoneinfo/Asia/Jerusalem "${DESTDIR}"/etc/localtime || exit 1

# install -c -m 600 -o root -g root tree/etc/gshadow "${DESTDIR}"/etc/gshadow || exit 1
# rm -f "${DESTDIR}"/etc/gshadow- || exit 1
# install -c -m 644 -o root -g root tree/etc/group "${DESTDIR}"/etc/group || exit 1
# rm -f "${DESTDIR}"/etc/group- || exit 1
# install -c -m 600 -o root -g root tree/etc/shadow "${DESTDIR}"/etc/shadow || exit 1
# rm -f "${DESTDIR}"/etc/shadow- || exit 1
# install -c -m 644 -o root -g root tree/etc/passwd "${DESTDIR}"/etc/passwd || exit 1
# rm -f "${DESTDIR}"/etc/passwd- || exit 1

install -d -m 700 -o guy -g guy "${DESTDIR}"/home/guy || exit 1
install -d -m 755 -o guy -g guy "${DESTDIR}"/home/guy/misc || exit 1
install -d -m 755 -o guy -g guy "${DESTDIR}"/home/guy/projects || exit 1
install -d -m 755 -o guy -g guy "${DESTDIR}"/home/guy/sync || exit 1

install -d -m 755 -o root -g root "${DESTDIR}"/var/xdg-cache || exit 1
install -d -m 700 -o guy -g guy "${DESTDIR}"/var/xdg-cache/guy || exit 1

install -d -m 1777 -o root -g users "${DESTDIR}"/home/public || exit 1
install -d -m 1777 -o root -g users "${DESTDIR}"/home/shares || exit 1
install -d -m 0700 -o guy -g guy "${DESTDIR}"/home/shares/guy || exit 1

install -c -m 644 -o root -g root tree/etc/locale.conf "${DESTDIR}"/etc/locale.conf || exit 1

install -c -m 644 -o root -g root tree/etc/inputrc "${DESTDIR}"/etc/inputrc || exit 1

install -c -m 640 -o root -g root tree/root/dot.profile "${DESTDIR}"/root/.profile || exit 1
install -c -m 640 -o root -g root tree/root/dot.bash_profile "${DESTDIR}"/root/.bash_profile || exit 1
install -c -m 640 -o root -g root tree/root/dot.bashrc "${DESTDIR}"/root/.bashrc || exit 1
install -c -m 644 -o guy -g guy tree/home/guy/dot.profile "${DESTDIR}"/home/guy/.profile || exit 1
install -c -m 644 -o guy -g guy tree/home/guy/dot.bash_profile "${DESTDIR}"/home/guy/.bash_profile || exit 1
install -c -m 644 -o guy -g guy tree/home/guy/dot.bashrc "${DESTDIR}"/home/guy/.bashrc || exit 1

install -c -m 644 -o root -g root tree/boot/syslinux/syslinux.cfg "${DESTDIR}"/boot/syslinux/syslinux.cfg || exit 1

install -c -m 644 -o root -g root tree/etc/modprobe.d/my_blacklist.conf "${DESTDIR}"/etc/modprobe.d/my_blacklist.conf || exit 1

install -c -m 644 -o root -g root tree/etc/sysctl.d/40-ipv6.conf "${DESTDIR}"/etc/sysctl.d/40-ipv6.conf || exit 1
ln -sfn /dev/null "${DESTDIR}"/etc/sysctl.d/50-coredump.conf || exit 1
install -c -m 644 -o root -g root tree/etc/sysctl.d/99-sysctl.conf "${DESTDIR}"/etc/sysctl.d/99-sysctl.conf || exit 1

install -c -m 644 -o root -g root tree/etc/security/limits.conf "${DESTDIR}"/etc/security/limits.conf || exit 1

install -c -m 644 -o root -g root tree/etc/fstab "${DESTDIR}"/etc/fstab || exit 1

# install -c -m 644 -o root -g root tree/etc/hostname "${DESTDIR}"/etc/hostname || exit 1

ln -sfn /run/resolv.conf "${DESTDIR}"/etc/resolv.conf || exit 1

install -c -m 644 -o root -g root tree/etc/nsswitch.conf "${DESTDIR}"/etc/nsswitch.conf || exit 1

install -c -m 644 -o root -g root tree/etc/nanorc "${DESTDIR}"/etc/nanorc || exit 1

# install -c -m 644 -o root -g root tree/etc/dhcpcd.duid "${DESTDIR}"/etc/dhcpcd.duid || exit 1
# install -c -m 400 -o root -g root tree/etc/dhcpcd.secret "${DESTDIR}"/etc/dhcpcd.secret || exit 1
install -c -m 644 -o root -g root tree/etc/dhcpcd.conf "${DESTDIR}"/etc/dhcpcd.conf || exit 1
ln -sfn /usr/lib/systemd/system/dhcpcd.service "${DESTDIR}"/etc/systemd/system/multi-user.target.wants/dhcpcd.service || exit 1

ln -sfn /usr/lib/systemd/system/syslog-ng.service "${DESTDIR}"/etc/systemd/system/syslog.service || exit 1
ln -sfn /usr/lib/systemd/system/syslog-ng.service "${DESTDIR}"/etc/systemd/system/multi-user.target.wants/syslog-ng.service || exit 1

ln -sfn /usr/lib/systemd/system/cronie.service "${DESTDIR}"/etc/systemd/system/multi-user.target.wants/cronie.service || exit 1

# install -c -m 644 -o root -g root tree/etc/ssh/ssh_known_hosts "${DESTDIR}"/etc/ssh/ssh_known_hosts || exit 1
install -c -m 644 -o root -g root tree/etc/ssh/ssh_config "${DESTDIR}"/etc/ssh/ssh_config || exit 1

install -d -m 700 -o guy -g guy "${DESTDIR}"/home/guy/.ssh || exit 1
# install -c -m 600 -o guy -g guy tree/home/guy/dot.ssh/id_rsa "${DESTDIR}"/home/guy/.ssh/id_rsa || exit 1

# install -c -m 600 -o root -g root tree/etc/ssh/ssh_host_dsa_key "${DESTDIR}"/etc/ssh/ssh_host_dsa_key || exit 1
# install -c -m 644 -o root -g root tree/etc/ssh/ssh_host_dsa_key.pub "${DESTDIR}"/etc/ssh/ssh_host_dsa_key.pub || exit 1
# install -c -m 600 -o root -g root tree/etc/ssh/ssh_host_ecdsa_key "${DESTDIR}"/etc/ssh/ssh_host_ecdsa_key || exit 1
# install -c -m 644 -o root -g root tree/etc/ssh/ssh_host_ecdsa_key.pub "${DESTDIR}"/etc/ssh/ssh_host_ecdsa_key.pub || exit 1
# install -c -m 600 -o root -g root tree/etc/ssh/ssh_host_ed25519_key "${DESTDIR}"/etc/ssh/ssh_host_ed25519_key || exit 1
# install -c -m 644 -o root -g root tree/etc/ssh/ssh_host_ed25519_key.pub "${DESTDIR}"/etc/ssh/ssh_host_ed25519_key.pub || exit 1
# install -c -m 600 -o root -g root tree/etc/ssh/ssh_host_rsa_key "${DESTDIR}"/etc/ssh/ssh_host_rsa_key || exit 1
# install -c -m 644 -o root -g root tree/etc/ssh/ssh_host_rsa_key.pub "${DESTDIR}"/etc/ssh/ssh_host_rsa_key.pub || exit 1
# install -c -m 600 -o root -g root /dev/null "${DESTDIR}"/etc/ssh/ssh_host_key || exit 1
# install -c -m 644 -o root -g root /dev/null "${DESTDIR}"/etc/ssh/ssh_host_key.pub || exit 1
install -c -m 640 -o root -g root tree/etc/ssh/sshd_config "${DESTDIR}"/etc/ssh/sshd_config || exit 1
ln -sfn /usr/lib/systemd/system/sshd.service "${DESTDIR}"/etc/systemd/system/multi-user.target.wants/sshd.service || exit 1

install -d -m 700 -o guy -g guy "${DESTDIR}"/home/guy/.ssh || exit 1
# install -c -m 600 -o guy -g guy tree/home/guy/dot.ssh/authorized_keys "${DESTDIR}"/home/guy/.ssh/authorized_keys || exit 1

ln -sfn /usr/lib/systemd/system/nfs-client.target "${DESTDIR}"/etc/systemd/system/multi-user.target.wants/nfs-client.target || exit 1
ln -sfn /usr/lib/systemd/system/nfs-client.target "${DESTDIR}"/etc/systemd/system/remote-fs.target.wants/nfs-client.target || exit 1

install -c -m 640 -o root -g root tree/etc/exports "${DESTDIR}"/etc/exports || exit 1

ln -sfn /usr/lib/systemd/system/nfs-server.service "${DESTDIR}"/etc/systemd/system/multi-user.target.wants/nfs-server.service || exit 1

install -c -m 644 -o guy -g guy tree/home/guy/dot.hgrc "${DESTDIR}"/home/guy/.hgrc || exit 1

ln -sfn /dev/null "${DESTDIR}"/etc/systemd/system/avahi-daemon.service || exit 1
ln -sfn /dev/null "${DESTDIR}"/etc/systemd/system/avahi-daemon.socket || exit 1
ln -sfn /dev/null "${DESTDIR}"/etc/systemd/system/avahi-dnsconfd.service || exit 1

# install -c -m 600 -o root -g root tree/var/lib/samba/private/passdb.tdb "${DESTDIR}"/var/lib/samba/private/passdb.tdb || exit 1
install -c -m 644 -o root -g root tree/etc/samba/smb.conf "${DESTDIR}"/etc/samba/smb.conf || exit 1
ln -sfn /usr/lib/systemd/system/smbd.service "${DESTDIR}"/etc/systemd/system/multi-user.target.wants/smbd.service || exit 1
ln -sfn /usr/lib/systemd/system/nmbd.service "${DESTDIR}"/etc/systemd/system/multi-user.target.wants/nmbd.service || exit 1

# install -c -m 644 -o root -g root tree/etc/machine-id "${DESTDIR}"/etc/machine-id || exit 1

install -d -m 700 -o guy -g guy "${DESTDIR}"/var/xdg-cache/guy/thumbnails || exit 1
ln -sfn /var/xdg-cache/guy/thumbnails "${DESTDIR}"/home/guy/.thumbnails || exit 1
chown -h guy:guy "${DESTDIR}"/home/guy/.thumbnails || exit 1

install -d -m 755 -o root -g root "${DESTDIR}"/usr/db/fontconfig || exit 1
mv -n "${DESTDIR}"/var/cache/fontconfig/* "${DESTDIR}"/usr/db/fontconfig 2>/dev/null
install -d -m 755 -o root -g root "${DESTDIR}"/etc/fonts || exit 1
install -c -m 644 -o root -g root tree/etc/fonts/local.conf "${DESTDIR}"/etc/fonts/local.conf || exit 1

install -d -m 755 -o root -g root "${DESTDIR}"/etc/X11 || exit 1
install -c -m 644 -o root -g root tree/etc/X11/xorg.conf "${DESTDIR}"/etc/X11/xorg.conf || exit 1

install -c -m 755 -o guy -g guy tree/home/guy/dot.xprofile "${DESTDIR}"/home/guy/.xprofile || exit 1
install -c -m 755 -o guy -g guy tree/home/guy/dot.xinitrc "${DESTDIR}"/home/guy/.xinitrc || exit 1
install -c -m 644 -o guy -g guy tree/home/guy/dot.xserverrc "${DESTDIR}"/home/guy/.xserverrc || exit 1
install -c -m 644 -o guy -g guy tree/home/guy/dot.Xresources "${DESTDIR}"/home/guy/.Xresources || exit 1

install -c -m 644 -o root -g root tree/etc/xdg/menus/all-applications.menu "${DESTDIR}"/etc/xdg/menus/all-applications.menu || exit 1

install -d -m 755 -o guy -g guy "${DESTDIR}"/home/guy/config || exit 1
install -d -m 755 -o guy -g guy "${DESTDIR}"/home/guy/config/gtk-2.0 || exit 1
install -c -m 644 -o guy -g guy tree/home/guy/config/gtk-2.0/gtkfilechooser.ini "${DESTDIR}"/home/guy/config/gtk-2.0/gtkfilechooser.ini || exit 1

install -c -m 644 -o guy -g guy tree/home/guy/dot.gtkrc-2.0 "${DESTDIR}"/home/guy/.gtkrc-2.0 || exit 1
install -c -m 644 -o guy -g guy tree/home/guy/dot.gtk-bookmarks "${DESTDIR}"/home/guy/.gtk-bookmarks || exit 1

install -d -m 755 -o guy -g guy "${DESTDIR}"/home/guy/config || exit 1
install -d -m 755 -o guy -g guy "${DESTDIR}"/home/guy/config/openbox || exit 1
install -c -m 644 -o guy -g guy tree/home/guy/config/openbox/menu.xml "${DESTDIR}"/home/guy/config/openbox/menu.xml || exit 1
install -c -m 644 -o guy -g guy tree/home/guy/config/openbox/rc.xml "${DESTDIR}"/home/guy/config/openbox/rc.xml || exit 1

install -d -m 755 -o guy -g guy "${DESTDIR}"/home/guy/config || exit 1
install -d -m 755 -o guy -g guy "${DESTDIR}"/home/guy/config/tint2 || exit 1
install -c -m 644 -o guy -g guy tree/home/guy/config/tint2/tint2rc "${DESTDIR}"/home/guy/config/tint2/tint2rc || exit 1

install -c -m 644 -o guy -g guy tree/home/guy/dot.gmrunrc "${DESTDIR}"/home/guy/.gmrunrc || exit 1

install -d -m 755 -o guy -g guy "${DESTDIR}"/home/guy/config || exit 1
install -d -m 755 -o guy -g guy "${DESTDIR}"/home/guy/config/leafpad || exit 1
# install -c -m 644 -o guy -g guy tree/home/guy/config/leafpad/leafpadrc "${DESTDIR}"/home/guy/config/leafpad/leafpadrc || exit 1
