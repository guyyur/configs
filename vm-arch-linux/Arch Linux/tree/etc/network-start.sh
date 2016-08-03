#!/usr/bin/sh

# replace fd00:2001:db8:0::X with real ULA prefix+EUI-64

echo 0 > /proc/sys/net/ipv6/conf/lan0/accept_ra
/usr/bin/ip link set dev lan0 up
/usr/bin/ip -6 addr add fd00:2001:db8:0::25/64 dev lan0
