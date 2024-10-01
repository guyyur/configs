#!/bin/sh

reason=$1
new_ipv6_prefix=${2%% *}  # Support only one prefix
state_file="/var/run/pf_update_pd_ipv6_lan.old"
anchor_name="pd_ipv6_lan"
template_file="/etc/pf_anchor-pd_ipv6_lan.conf.in"
conf_file="/var/run/pf_anchor-pd_ipv6_lan.conf"

case $reason in
  up)
    old_ipv6_prefix=$(cat "${state_file}" 2>/dev/null)
    if [ "${new_ipv6_prefix}" != "${old_ipv6_prefix}" ]; then
      if [ -n "${old_ipv6_prefix}" ]; then
        pfctl -a ${anchor_name} -F rules
      fi
      sed -e "s@LAN_DELEGATED_PREFIX@${new_ipv6_prefix}@" "${template_file}" > "${conf_file}"
      if [ $? -eq 0 ]; then
        pfctl -a ${anchor_name} -f "${conf_file}"
      fi
      printf "${new_ipv6_prefix}" > "${state_file}"
    fi
    ;;
  down)
    if [ -e "${state_file}" ]; then
      rm -f "${state_file}"
      pfctl -a ${anchor_name} -F rules
    fi
    ;;
esac
