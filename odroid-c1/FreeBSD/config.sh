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
install -c -m 755 -o root -g wheel tree/etc/mtree/LOCAL.var.sh "${DESTDIR}"/etc/mtree/LOCAL.var.sh || exit 1

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

install -d -m 755 -o guy -g guy "${DESTDIR}"/home/guy/config || exit 1

install -d -m 755 -o root -g wheel "${DESTDIR}"/var/xdg-cache || exit 1
install -d -m 700 -o guy -g guy "${DESTDIR}"/var/xdg-cache/guy || exit 1

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

install -c -m 644 -o root -g wheel tree/boot/loader.conf "${DESTDIR}"/boot/loader.conf || exit 1

install -c -m 644 -o root -g wheel tree/boot/custom/boot.ini "${DESTDIR}"/boot/custom/boot.ini || exit 1

install -c -m 644 -o root -g wheel tree/etc/hostid "${DESTDIR}"/etc/hostid || exit 1

install -c -m 644 -o root -g wheel tree/etc/devfs.conf "${DESTDIR}"/etc/devfs.conf || exit 1
install -c -m 644 -o root -g wheel tree/etc/devfs.rules "${DESTDIR}"/etc/devfs.rules || exit 1

install -c -m 644 -o root -g wheel tree/etc/sysctl.conf "${DESTDIR}"/etc/sysctl.conf || exit 1

install -l s 'abort:false,junk:false' "${DESTDIR}"/etc/malloc.conf || exit 1

install -c -m 644 -o root -g wheel tree/etc/fstab "${DESTDIR}"/etc/fstab || exit 1

install -c -m 644 -o root -g wheel tree/etc/ttys "${DESTDIR}"/etc/ttys || exit 1

install -c -m 644 -o root -g wheel tree/etc/start_if.lan0 "${DESTDIR}"/etc/start_if.lan0 || exit 1

install -c -m 644 -o root -g wheel tree/etc/start_if.wan0 "${DESTDIR}"/etc/start_if.wan0 || exit 1

install -c -m 644 -o root -g wheel tree/etc/hosts "${DESTDIR}"/etc/hosts || exit 1

install -c -m 644 -o root -g wheel tree/etc/resolv.conf "${DESTDIR}"/etc/resolv.conf || exit 1

install -c -m 644 -o root -g wheel tree/etc/resolvconf.conf "${DESTDIR}"/etc/resolvconf.conf || exit 1

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

install -c -m 644 -o root -g wheel tree/etc/rtadvd.conf "${DESTDIR}"/etc/rtadvd.conf || exit 1

install -c -m 640 -o root -g wheel tree/etc/pf.conf "${DESTDIR}"/etc/pf.conf || exit 1
install -c -m 640 -o root -g wheel tree/etc/pf_anchor-router_ipv6.conf.in "${DESTDIR}"/etc/pf_anchor-router_ipv6.conf.in || exit 1

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

install -c -m 644 -o root -g wheel /dev/null "${DESTDIR}"/var/cache/dnsmasq-resolv.conf || exit 1
install -c -m 644 -o root -g wheel tree/etc/local/dnsmasq-hosts "${DESTDIR}"/etc/local/dnsmasq-hosts || exit 1
install -c -m 644 -o root -g wheel tree/etc/local/dnsmasq.conf "${DESTDIR}"/etc/local/dnsmasq.conf || exit 1

install -c -m 644 -o root -g wheel tree/etc/local/miniupnpd.conf "${DESTDIR}"/etc/local/miniupnpd.conf || exit 1

install -c -N "${DESTDIR}"/etc -m 640 -o ddnshupd -g ddnshupd tree/etc/local/ddnshupd-ipv4.conf "${DESTDIR}"/etc/local/ddnshupd-ipv4.conf || exit 1
install -c -N "${DESTDIR}"/etc -m 640 -o ddnshupd -g ddnshupd tree/etc/local/ddnshupd-ipv6.conf "${DESTDIR}"/etc/local/ddnshupd-ipv6.conf || exit 1

install -c -m 755 -o root -g wheel tree/etc/local/dhcpcd.exit-hook "${DESTDIR}"/etc/local/dhcpcd.exit-hook || exit 1
install -c -m 644 -o root -g wheel tree/etc/local/dhcpcd.duid "${DESTDIR}"/etc/local/dhcpcd.duid || exit 1
install -c -m 400 -o root -g wheel tree/etc/local/dhcpcd.secret "${DESTDIR}"/etc/local/dhcpcd.secret || exit 1
install -c -m 644 -o root -g wheel tree/etc/local/dhcpcd.conf "${DESTDIR}"/etc/local/dhcpcd.conf || exit 1

install -d -m 755 -o root -g wheel "${DESTDIR}"/etc/local/mpd5 || exit 1
install -c -m 640 -o root -g wheel tree/etc/local/mpd5/mpd.conf "${DESTDIR}"/etc/local/mpd5/mpd.conf || exit 1
install -c -m 750 -o root -g wheel tree/etc/local/mpd5/mpd-up-script.sh "${DESTDIR}"/etc/local/mpd5/mpd-up-script.sh || exit 1
install -c -m 750 -o root -g wheel tree/etc/local/mpd5/mpd-down-script.sh "${DESTDIR}"/etc/local/mpd5/mpd-down-script.sh || exit 1

install -d -m 755 -o root -g wheel "${DESTDIR}"/etc/local/openvpn || exit 1
install -c -m 644 -o root -g wheel tree/etc/local/openvpn/dh.pem "${DESTDIR}"/etc/local/openvpn/dh.pem || exit 1
install -c -m 644 -o root -g wheel tree/etc/local/openvpn/ca.crt "${DESTDIR}"/etc/local/openvpn/ca.crt || exit 1
install -c -m 644 -o root -g wheel tree/etc/local/openvpn/server.crt "${DESTDIR}"/etc/local/openvpn/server.crt || exit 1
install -c -m 600 -o root -g wheel tree/etc/local/openvpn/server.key "${DESTDIR}"/etc/local/openvpn/server.key || exit 1
install -c -m 644 -o root -g wheel tree/etc/local/openvpn/openvpn.conf "${DESTDIR}"/etc/local/openvpn/openvpn.conf || exit 1

