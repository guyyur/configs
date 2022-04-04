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


#
install -d -m 755 -o root -g root "${DESTDIR}"/etc || exit 1

ln -sfn ../usr/share/zoneinfo/Asia/Jerusalem "${DESTDIR}"/etc/localtime || exit 1

install -c -m 644 -o root -g root tree/etc/login.defs "${DESTDIR}"/etc/login.defs || exit 1

install -c -m 600 -o root -g root tree/etc/gshadow "${DESTDIR}"/etc/gshadow || exit 1
install -c -m 644 -o root -g root tree/etc/group "${DESTDIR}"/etc/group || exit 1
install -c -m 600 -o root -g root tree/etc/shadow "${DESTDIR}"/etc/shadow || exit 1
install -c -m 644 -o root -g root tree/etc/passwd "${DESTDIR}"/etc/passwd || exit 1

install -d -m 750 -o root -g root "${DESTDIR}"/root || exit 1

install -d -m 755 -o root -g root "${DESTDIR}"/etc/xdg || exit 1

install -d -m 755 -o guy -g guy "${DESTDIR}"/home/guy/config || exit 1

install -c -m 644 -o root -g root tree/etc/locale.gen "${DESTDIR}"/etc/locale.gen || exit 1
install -c -m 644 -o root -g root tree/etc/locale.conf "${DESTDIR}"/etc/locale.conf || exit 1

install -c -m 644 -o root -g root tree/etc/inputrc "${DESTDIR}"/etc/inputrc || exit 1

ln -sfn ../usr/lib/os-release "${DESTDIR}"/etc/os-release || exit 1

install -d -m 755 -o root -g root "${DESTDIR}"/etc/systemd || exit 1
install -d -m 755 -o root -g root "${DESTDIR}"/etc/systemd/system || exit 1
install -d -m 755 -o root -g root "${DESTDIR}"/etc/systemd/system/multi-user.target.wants || exit 1
install -d -m 755 -o root -g root "${DESTDIR}"/etc/systemd/system/remote-fs.target.wants || exit 1
install -d -m 755 -o root -g root "${DESTDIR}"/etc/systemd/system/sockets.target.wants || exit 1

install -d -m 755 -o root -g root "${DESTDIR}"/boot/syslinux || exit 1
install -c -m 644 -o root -g root tree/boot/syslinux/syslinux.cfg "${DESTDIR}"/boot/syslinux/syslinux.cfg || exit 1

install -d -m 755 -o root -g root "${DESTDIR}"/etc/modprobe.d || exit 1
install -c -m 644 -o root -g root tree/etc/modprobe.d/my_blacklist.conf "${DESTDIR}"/etc/modprobe.d/my_blacklist.conf || exit 1

install -d -m 755 -o root -g root "${DESTDIR}"/etc/udev || exit 1
install -d -m 755 -o root -g root "${DESTDIR}"/etc/udev/rules.d || exit 1

install -c -m 644 -o root -g root tree/etc/udev/rules.d/81-network-names.rules "${DESTDIR}"/etc/udev/rules.d/81-network-names.rules || exit 1

install -d -m 755 -o root -g root "${DESTDIR}"/etc/sysctl.d || exit 1
install -c -m 644 -o root -g root tree/etc/sysctl.d/40-ipv6.conf "${DESTDIR}"/etc/sysctl.d/40-ipv6.conf || exit 1
ln -sfn /dev/null "${DESTDIR}"/etc/sysctl.d/50-coredump.conf || exit 1
install -c -m 644 -o root -g root tree/etc/sysctl.d/99-sysctl.conf "${DESTDIR}"/etc/sysctl.d/99-sysctl.conf || exit 1

install -d -m 755 -o root -g root "${DESTDIR}"/etc/security || exit 1

install -c -m 644 -o root -g root tree/etc/security/limits.conf "${DESTDIR}"/etc/security/limits.conf || exit 1

install -c -m 644 -o root -g root tree/etc/hostname "${DESTDIR}"/etc/hostname || exit 1

install -c -m 444 -o root -g root tree/etc/machine-id "${DESTDIR}"/etc/machine-id || exit 1

ln -sfn ../run/resolv.conf "${DESTDIR}"/etc/resolv.conf || exit 1

install -c -m 644 -o root -g root tree/etc/nsswitch.conf "${DESTDIR}"/etc/nsswitch.conf || exit 1

install -c -m 644 -o root -g root tree/etc/fstab "${DESTDIR}"/etc/fstab || exit 1

ln -sfn /dev/null "${DESTDIR}"/etc/systemd/system/systemd-tmpfiles-clean.timer || exit 1
ln -sfn /dev/null "${DESTDIR}"/etc/systemd/system/systemd-tmpfiles-clean.service || exit 1

install -c -m 640 -o root -g root tree/root/.profile "${DESTDIR}"/root/.profile || exit 1

install -c -m 644 -o guy -g guy tree/home/guy/.profile "${DESTDIR}"/home/guy/.profile || exit 1

install -c -m 640 -o root -g root tree/root/.bashrc "${DESTDIR}"/root/.bashrc || exit 1
install -c -m 644 -o guy -g guy tree/home/guy/.bashrc "${DESTDIR}"/home/guy/.bashrc || exit 1

install -c -m 644 -o root -g root tree/etc/nanorc "${DESTDIR}"/etc/nanorc || exit 1

install -c -m 640 -o root -g root tree/root/.zprofile "${DESTDIR}"/root/.zprofile || exit 1
install -c -m 640 -o root -g root tree/root/.zshrc "${DESTDIR}"/root/.zshrc || exit 1
install -c -m 644 -o guy -g guy tree/home/guy/.zprofile "${DESTDIR}"/home/guy/.zprofile || exit 1
install -c -m 644 -o guy -g guy tree/home/guy/.zshrc "${DESTDIR}"/home/guy/.zshrc || exit 1

install -c -m 755 -o root -g root tree/etc/network-if.sh "${DESTDIR}"/etc/network-if.sh || exit 1
install -c -m 644 -o root -g root tree/etc/systemd/system/network-if@.service "${DESTDIR}"/etc/systemd/system/network-if@.service || exit 1

ln -sfn /etc/systemd/system/network-if@.service "${DESTDIR}"/etc/systemd/system/multi-user.target.wants/network-if@lan0.service || exit 1

install -d -m 700 -o dhcpcd -g dhcpcd "${DESTDIR}"/var/lib/dhcpcd || exit 1
install -d -m 755 -o root -g root "${DESTDIR}"/var/lib/dhcpcd/var || exit 1
install -d -m 755 -o root -g root "${DESTDIR}"/var/lib/dhcpcd/var/lib || exit 1
install -d -m 755 -o dhcpcd -g dhcpcd "${DESTDIR}"/var/lib/dhcpcd/var/lib/dhcpcd || exit 1
install -c -m 644 -o root -g root tree/etc/dhcpcd.duid.backup "${DESTDIR}"/etc/dhcpcd.duid.backup || exit 1
install -c -m 644 -o dhcpcd -g dhcpcd "${DESTDIR}"/etc/dhcpcd.duid.backup "${DESTDIR}"/var/lib/dhcpcd/var/lib/dhcpcd/duid || exit 1
install -c -m 600 -o root -g root tree/etc/dhcpcd.secret.backup "${DESTDIR}"/etc/dhcpcd.secret.backup || exit 1
install -c -m 600 -o dhcpcd -g dhcpcd "${DESTDIR}"/etc/dhcpcd.secret.backup "${DESTDIR}"/var/lib/dhcpcd/var/lib/dhcpcd/secret || exit 1
install -c -m 644 -o root -g root tree/etc/dhcpcd.conf "${DESTDIR}"/etc/dhcpcd.conf || exit 1


ln -sfn /usr/lib/systemd/system/dhcpcd.service "${DESTDIR}"/etc/systemd/system/multi-user.target.wants/dhcpcd.service || exit 1

install -d -m 755 -o root -g root "${DESTDIR}"/etc/ssh || exit 1
install -c -m 644 -o root -g root tree/etc/ssh/ssh_known_hosts "${DESTDIR}"/etc/ssh/ssh_known_hosts || exit 1
install -c -m 644 -o root -g root tree/etc/ssh/ssh_config "${DESTDIR}"/etc/ssh/ssh_config || exit 1

install -d -m 700 -o guy -g guy "${DESTDIR}"/home/guy/.ssh || exit 1
install -c -m 600 -o guy -g guy tree/home/guy/.ssh/id_ed25519 "${DESTDIR}"/home/guy/.ssh/id_ed25519 || exit 1
install -c -m 644 -o guy -g guy tree/home/guy/.ssh/id_ed25519.pub "${DESTDIR}"/home/guy/.ssh/id_ed25519.pub || exit 1
install -c -m 600 -o guy -g guy tree/home/guy/.ssh/id_rsa "${DESTDIR}"/home/guy/.ssh/id_rsa || exit 1
install -c -m 644 -o guy -g guy tree/home/guy/.ssh/id_rsa.pub "${DESTDIR}"/home/guy/.ssh/id_rsa.pub || exit 1

install -c -m 600 -o root -g root tree/etc/ssh/ssh_host_ed25519_key "${DESTDIR}"/etc/ssh/ssh_host_ed25519_key || exit 1
install -c -m 644 -o root -g root tree/etc/ssh/ssh_host_ed25519_key.pub "${DESTDIR}"/etc/ssh/ssh_host_ed25519_key.pub || exit 1
install -c -m 644 -o root -g root tree/etc/ssh/ssh_host_ed25519_key-cert.pub "${DESTDIR}"/etc/ssh/ssh_host_ed25519_key-cert.pub || exit 1
install -c -m 600 -o root -g root tree/etc/ssh/ssh_host_rsa_key "${DESTDIR}"/etc/ssh/ssh_host_rsa_key || exit 1
install -c -m 644 -o root -g root tree/etc/ssh/ssh_host_rsa_key.pub "${DESTDIR}"/etc/ssh/ssh_host_rsa_key.pub || exit 1
install -c -m 640 -o root -g root tree/etc/ssh/sshd_config "${DESTDIR}"/etc/ssh/sshd_config || exit 1
install -c -m 644 -o root -g root tree/etc/systemd/system/sshdgenkeys.service "${DESTDIR}"/etc/systemd/system/sshdgenkeys.service || exit 1
ln -sfn /usr/lib/systemd/system/sshd.service "${DESTDIR}"/etc/systemd/system/multi-user.target.wants/sshd.service || exit 1

install -c -m 600 -o guy -g guy tree/home/guy/.ssh/authorized_keys "${DESTDIR}"/home/guy/.ssh/authorized_keys || exit 1

install -c -m 640 -o root -g root tree/etc/exports "${DESTDIR}"/etc/exports || exit 1

ln -sfn /usr/lib/systemd/system/nfs-server.service "${DESTDIR}"/etc/systemd/system/multi-user.target.wants/nfs-server.service || exit 1

install -c -m 644 -o root -g root tree/root/.toprc "${DESTDIR}"/root/.toprc || exit 1
install -c -m 644 -o guy -g guy tree/home/guy/.toprc "${DESTDIR}"/home/guy/.toprc || exit 1

install -c -m 644 -o root -g root tree/etc/tmux.conf "${DESTDIR}"/etc/tmux.conf || exit 1

install -d -m 755 -o guy -g guy "${DESTDIR}"/home/guy/config/git || exit 1
install -c -m 644 -o guy -g guy tree/home/guy/config/git/config "${DESTDIR}"/home/guy/config/git/config || exit 1

install -d -m 755 -o root -g root "${DESTDIR}"/etc/fonts || exit 1
install -c -m 644 -o root -g root tree/etc/fonts/local.conf "${DESTDIR}"/etc/fonts/local.conf || exit 1

install -c -m 755 -o guy -g guy tree/home/guy/.xprofile "${DESTDIR}"/home/guy/.xprofile || exit 1
install -c -m 644 -o guy -g guy tree/home/guy/.Xresources "${DESTDIR}"/home/guy/.Xresources || exit 1
install -c -m 644 -o guy -g guy tree/home/guy/.xserverrc "${DESTDIR}"/home/guy/.xserverrc || exit 1
install -c -m 755 -o guy -g guy tree/home/guy/.xinitrc "${DESTDIR}"/home/guy/.xinitrc || exit 1

install -d -m 755 -o guy -g guy "${DESTDIR}"/home/guy/config/gtk-2.0 || exit 1
install -c -m 644 -o guy -g guy tree/home/guy/config/gtk-2.0/gtkfilechooser.ini "${DESTDIR}"/home/guy/config/gtk-2.0/gtkfilechooser.ini || exit 1
install -c -m 644 -o guy -g guy tree/home/guy/config/gtk-2.0/gtkrc "${DESTDIR}"/home/guy/config/gtk-2.0/gtkrc || exit 1

install -d -m 755 -o guy -g guy "${DESTDIR}"/home/guy/config/gtk-3.0 || exit 1
install -c -m 644 -o guy -g guy tree/home/guy/config/gtk-3.0/settings.ini "${DESTDIR}"/home/guy/config/gtk-3.0/settings.ini || exit 1
install -c -m 644 -o guy -g guy tree/home/guy/config/gtk-3.0/bookmarks "${DESTDIR}"/home/guy/config/gtk-3.0/bookmarks || exit 1

install -d -m 755 -o root -g root "${DESTDIR}"/etc/xdg/autostart || exit 1

install -c -m 644 -o root -g root tree/etc/xdg/autostart/lxqt-notifications-OPENBOX.desktop "${DESTDIR}"/etc/xdg/autostart/lxqt-notifications-OPENBOX.desktop || exit 1

install -d -m 755 -o root -g root "${DESTDIR}"/etc/xdg/menus || exit 1
install -c -m 644 -o root -g root tree/etc/xdg/menus/all-applications.menu "${DESTDIR}"/etc/xdg/menus/all-applications.menu || exit 1

install -d -m 755 -o guy -g guy "${DESTDIR}"/home/guy/config/openbox || exit 1
install -c -m 644 -o guy -g guy tree/home/guy/config/openbox/menu.xml "${DESTDIR}"/home/guy/config/openbox/menu.xml || exit 1
install -c -m 644 -o guy -g guy tree/home/guy/config/openbox/rc.xml "${DESTDIR}"/home/guy/config/openbox/rc.xml || exit 1

install -d -m 755 -o guy -g guy "${DESTDIR}"/home/guy/config/tint2 || exit 1
install -c -m 644 -o guy -g guy tree/home/guy/config/tint2/tint2rc "${DESTDIR}"/home/guy/config/tint2/tint2rc || exit 1

install -c -m 644 -o guy -g guy tree/home/guy/.gmrunrc "${DESTDIR}"/home/guy/.gmrunrc || exit 1

install -d -m 755 -o guy -g guy "${DESTDIR}"/home/guy/config/pcmanfm-qt || exit 1
install -d -m 755 -o guy -g guy "${DESTDIR}"/home/guy/config/pcmanfm-qt/default || exit 1
install -c -m 644 -o guy -g guy tree/home/guy/config/pcmanfm-qt/default/settings.conf "${DESTDIR}"/home/guy/config/pcmanfm-qt/default/settings.conf || exit 1

install -d -m 755 -o guy -g guy "${DESTDIR}"/home/guy/config/leafpad || exit 1
install -c -m 644 -o guy -g guy tree/home/guy/config/leafpad/leafpadrc "${DESTDIR}"/home/guy/config/leafpad/leafpadrc || exit 1

install -d -m 755 -o guy -g guy "${DESTDIR}"/home/guy/config/featherpad || exit 1
install -c -m 644 -o guy -g guy tree/home/guy/config/featherpad/fp.conf "${DESTDIR}"/home/guy/config/featherpad/fp.conf || exit 1
