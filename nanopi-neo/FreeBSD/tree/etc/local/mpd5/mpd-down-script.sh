#!/bin/sh

case $2 in
  inet)
    ddnshupd_ipv4_pid=$(cat /var/run/ddnshupd-ipv4.pid 2>/dev/null)
    [ -n "$ddnshupd_ipv4_pid" ] && kill -TERM "$ddnshupd_ipv4_pid"
    
    /sbin/resolvconf -d "$1:mpd"
    ;;
  inet6)
    dhcpcd_pid=$(cat /var/run/dhcpcd.pid 2>/dev/null)
    [ -n "$dhcpcd_pid" ] && kill -TERM "$dhcpcd_pid"
    
    route del -net -inet6 default $4
    ;;
esac
