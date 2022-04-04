#!/usr/bin/sh

# replace fd00:2001:db8:0 with real ULA prefix

ifname=$1

echo 0 > /proc/sys/net/ipv6/conf/"${ifname}"/accept_ra
/usr/bin/ip link set dev "${ifname}" up
eui64=$(cat "/sys/class/net/${ifname}/address" | ipv6calc --mac_to_eui64)
if [ -n "${eui64}" ]; then
  /usr/bin/ip -6 addr add "fd00:2001:db8:0:${eui64}/64" dev "${ifname}"
fi
