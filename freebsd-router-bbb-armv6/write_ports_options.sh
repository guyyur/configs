#!/bin/sh

# -- check for root --
if [ "`id -u`" != "0" ]; then
  echo "ports.sh: sorry, this must be done as root." 1>&2
  exit 1
fi


# -- init_port_options(port_option_dirname, port_name, port_version) --
init_port_options()
{
  port_option_dirname="$1"
  port_name="$2"
  port_version="$3"
  port_complete_options_list=""
  port_options=""
}


# -- add_port_option(option_string) --
add_port_option()
{
  local option_string="$1"
  local option_name="${option_string#??? }"
  local option_state="${option_string%% $option_name}"
  
  port_complete_options_list="${port_complete_options_list} ${option_name}"
  if [ "$option_state" = "[x]" -o "$option_state" = "(*)" ]; then
    port_options="${port_options} OPTIONS_FILE_SET+=${option_name}"
  else
    port_options="${port_options} OPTIONS_FILE_UNSET+=${option_name}"
  fi
}


# -- create_port_options() --
create_port_options()
{
  if [ ! -e /usr/local/db/ports/"$port_option_dirname" ]; then
    mkdir -m 755 /usr/local/db/ports/"$port_option_dirname" || exit 1
  fi
  
  port_options_newline=`echo "${port_options# }" | tr ' ' '\n'`
  
  cat << EOF > /usr/local/db/ports/"$port_option_dirname"/options || exit 1
# This file is auto-generated by 'make config'.
# Options for ${port_name}-${port_version}
_OPTIONS_READ=${port_name}-${port_version}
_FILE_COMPLETE_OPTIONS_LIST=${port_complete_options_list# }
${port_options_newline}
EOF
}


# -- archivers/gtar OPTIONS --


# -- archivers/lzo2 OPTIONS --
init_port_options "archivers_lzo2" "lzo2" "2.06_2"
add_port_option "[ ] DOCS"
add_port_option "[ ] EXAMPLES"
create_port_options


# -- benchmarks/iperf OPTIONS --
init_port_options "benchmarks_iperf" "iperf" "2.0.5"
add_port_option "[ ] DOCS"
add_port_option "[x] IPV6"
add_port_option "[x] THREADS"
create_port_options


# -- dns/dnsmasq OPTIONS --
init_port_options "dns_dnsmasq" "dnsmasq" "2.72,1"
add_port_option "[ ] DBUS"
add_port_option "[ ] DNSSEC"
add_port_option "[ ] DOCS"
add_port_option "[x] IPV6"
add_port_option "[ ] LUA"
add_port_option "( ) IDN"
add_port_option "( ) NLS"
create_port_options


# -- editors/nano OPTIONS --
init_port_options "editors_nano" "nano" "2.4.0"
add_port_option "[ ] DOCS"
add_port_option "[ ] EXAMPLES"
add_port_option "[ ] NLS"
create_port_options


# -- net/miniupnpd OPTIONS --
init_port_options "net_miniupnpd" "miniupnpd" "1.9,1"
add_port_option "[ ] CHECK_PORTINUSE"
add_port_option "[x] IPV6"
add_port_option "[ ] LEASEFILE"
add_port_option "[x] PF_ENABLE_FILTER_RULES"
add_port_option "[ ] UPNP_IGDV2"
add_port_option "[ ] UPNP_STRICT"
create_port_options


# -- net/mpd5 OPTIONS --
init_port_options "net_mpd5" "mpd" "5.7"
add_port_option "[ ] NG_IPACCT"
create_port_options


# -- ports-mgmt/portmaster OPTIONS --
init_port_options "ports-mgmt_portmaster" "portmaster" "3.17"
add_port_option "[ ] BASH"
add_port_option "[ ] ZSH"
create_port_options


# -- security/openvpn OPTIONS --
init_port_options "security_openvpn" "openvpn" "2.3.6_3"
add_port_option "[ ] DOCS"
add_port_option "[ ] EASYRSA"
add_port_option "[ ] ENGINEFIX"
add_port_option "[ ] EXAMPLES"
add_port_option "[ ] PKCS11"
add_port_option "[ ] PW_SAVE"
add_port_option "[ ] X509ALTUSERNAME"
add_port_option "(*) OPENSSL"
add_port_option "( ) POLARSSL"
create_port_options
