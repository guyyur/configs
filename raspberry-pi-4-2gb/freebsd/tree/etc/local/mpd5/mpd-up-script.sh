#!/bin/sh

case $2 in
  inet)
    # update resolvconf
    nameserver1=
    [ -n "${6%% *}" ] && nameserver1="nameserver ${6#dns1 }"
    nameserver2=
    [ -n "${7%% *}" ] && nameserver2="nameserver ${7#dns2 }"
    printf "%s\n%s\n" "${nameserver1}" "${nameserver2}" | /sbin/resolvconf -a "$1:mpd"
    
    # update dynamic dns
    /usr/local/sbin/ddnshupd -p /var/run/ddnshupd-ipv4.pid ${3%%/*} /usr/local/etc/ddnshupd-ipv4.conf
    ;;
  inet6)
    route add -net -inet6 default $4
    
    /usr/local/sbin/dhcpcd
    ;;
esac
