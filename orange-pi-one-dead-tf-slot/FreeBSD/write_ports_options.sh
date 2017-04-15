#!/bin/sh

# -- check for root --
if [ "`id -u`" != "0" ]; then
  echo "write_ports_options.sh: sorry, this must be done as root." 1>&2
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


# -- benchmarks/iperf OPTIONS --
init_port_options "benchmarks_iperf" "iperf" "2.0.5"
add_port_option "[ ] DOCS"
add_port_option "[x] IPV6"
add_port_option "[x] THREADS"
create_port_options


# -- devel/git OPTIONS --
init_port_options "devel_git" "git" "2.11.0_3"
add_port_option "[ ] CONTRIB"
add_port_option "[x] CURL"
add_port_option "[ ] CVS"
add_port_option "[ ] GITWEB"
add_port_option "[ ] GUI"
add_port_option "[ ] HTMLDOCS"
add_port_option "[x] ICONV"
add_port_option "[ ] NLS"
add_port_option "[ ] P4"
add_port_option "[x] PCRE"
add_port_option "[x] PERL"
add_port_option "[ ] SEND_EMAIL"
add_port_option "[ ] SUBTREE"
add_port_option "[ ] SVN"
create_port_options


# -- devel/libevent OPTIONS --
init_port_options "devel_libevent" "libevent" "2.1.8"
add_port_option "[x] OPENSSL"
add_port_option "[x] THREADS"
create_port_options


# -- devel/m4 OPTIONS --
init_port_options "devel_m4" "m4" "1.4.17_1,1"
add_port_option "[ ] EXAMPLES"
add_port_option "[ ] LIBSIGSEGV"
create_port_options


# -- devel/pcre OPTIONS --
init_port_options "devel_pcre" "pcre" "8.39"
add_port_option "[ ] DOCS"
add_port_option "[x] MAN3"
add_port_option "[x] STACK_RECURSION"
add_port_option "( ) LIBEDIT"
add_port_option "( ) READLINE"
create_port_options


# -- devel/readline OPTIONS --
init_port_options "devel_readline" "readline" "6.3.6_1"
add_port_option "[ ] DOCS"
add_port_option "[x] TERMCAP"
create_port_options


# -- dns/dnsmasq OPTIONS --
init_port_options "dns_dnsmasq" "dnsmasq" "2.76,1"
add_port_option "[ ] DBUS"
add_port_option "[ ] DNSSEC"
add_port_option "[ ] DOCS"
add_port_option "[ ] IPSET"
add_port_option "[x] IPV6"
add_port_option "[ ] LUA"
add_port_option "( ) IDN"
add_port_option "( ) NLS"
create_port_options


# -- ftp/curl OPTIONS --
init_port_options "ftp_curl" "curl" "7.51.0_1"
add_port_option "[x] CA_BUNDLE"
add_port_option "[x] COOKIES"
add_port_option "[ ] CURL_DEBUG"
add_port_option "[ ] DEBUG"
add_port_option "[ ] DOCS"
add_port_option "[ ] EXAMPLES"
add_port_option "[ ] HTTP2"
add_port_option "[ ] IDN"
add_port_option "[x] IPV6"
add_port_option "[ ] LDAP"
add_port_option "[ ] LDAPS"
add_port_option "[ ] LIBSSH2"
add_port_option "[ ] METALINK"
add_port_option "[x] PROXY"
add_port_option "[ ] PSL"
add_port_option "[ ] RTMP"
add_port_option "[ ] SMB"
add_port_option "[x] TLS_SRP"
add_port_option "( ) GSSAPI_BASE"
add_port_option "( ) GSSAPI_HEIMDAL"
add_port_option "( ) GSSAPI_MIT"
add_port_option "(*) GSSAPI_NONE"
add_port_option "( ) CARES"
add_port_option "(*) THREADED_RESOLVER"
add_port_option "( ) GNUTLS"
add_port_option "( ) NSS"
add_port_option "(*) OPENSSL"
add_port_option "( ) POLARSSL"
add_port_option "( ) WOLFSSL"
create_port_options


# -- lang/perl5.24 OPTIONS --
init_port_options "lang_perl5.24" "perl5" "5.24.1.r4_1"
add_port_option "[ ] DEBUG"
add_port_option "[ ] DTRACE"
add_port_option "[ ] GDBM"
add_port_option "[x] MULTIPLICITY"
add_port_option "[x] PERL_64BITINT"
add_port_option "[x] PTHREAD"
add_port_option "[ ] SITECUSTOMIZE"
add_port_option "(*) THREADS"
add_port_option "( ) PERL_MALLOC"
create_port_options


# -- lang/python27 OPTIONS --
init_port_options "lang_python27" "python27" "2.7.8_6"
add_port_option "[ ] DEBUG"
add_port_option "[x] IPV6"
add_port_option "[x] LIBFFI"
add_port_option "[ ] NLS"
add_port_option "[x] PYMALLOC"
add_port_option "[x] SEM"
add_port_option "[x] THREADS"
add_port_option "( ) UCS2"
add_port_option "(*) UCS4"
create_port_options


# -- net/miniupnpd OPTIONS --
init_port_options "net_miniupnpd" "miniupnpd" "1.9.20160113,1"
add_port_option "[ ] CHECK_PORTINUSE"
add_port_option "[x] IPV6"
add_port_option "[ ] LEASEFILE"
add_port_option "[x] PF_FILTER_RULES"
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


# -- security/ca_root_nss OPTIONS --
init_port_options "security_ca_root_nss" "ca_root_nss" "3.15.5"
add_port_option "[ ] ETCSYMLINK"
create_port_options


# -- security/openvpn OPTIONS --
init_port_options "security_openvpn" "openvpn" "2.4.0"
add_port_option "[ ] DOCS"
add_port_option "[ ] EASYRSA"
add_port_option "[ ] EXAMPLES"
add_port_option "[x] LZ4"
add_port_option "[ ] PKCS11"
add_port_option "[ ] SMALL"
add_port_option "[ ] TEST"
add_port_option "[ ] TUNNELBLICK"
add_port_option "[ ] X509ALTUSERNAME"
add_port_option "(*) OPENSSL"
add_port_option "( ) MBEDTLS"
create_port_options


# -- shells/bash OPTIONS --
init_port_options "shells_bash" "bash" "4.4.5"
add_port_option "[x] COLONBREAKSWORDS"
add_port_option "[ ] DOCS"
add_port_option "[ ] HELP"
add_port_option "[ ] NLS"
add_port_option "[ ] STATIC"
add_port_option "[ ] SYSLOG"
create_port_options


# -- shells/zsh OPTIONS --
init_port_options "shells_zsh" "zsh" "5.2_2"
add_port_option "[ ] DEBUG"
add_port_option "[ ] DOCS"
add_port_option "[ ] ETCDIR"
add_port_option "[ ] EXAMPLES"
add_port_option "[ ] GDBM"
add_port_option "[ ] MEM"
add_port_option "[ ] PCRE"
add_port_option "[ ] STATIC"
create_port_options


# -- sysutils/tmux OPTIONS --
init_port_options "sysutils_tmux" "tmux" "2.3_2"
add_port_option "[ ] BACKSPACE"
add_port_option "[ ] DOCS"
add_port_option "[ ] EXAMPLES"
add_port_option "[ ] LIBEVENT_STATIC"
create_port_options


# -- textproc/libxml2 OPTIONS --
init_port_options "textproc_libxml2" "libxml2" "2.9.2_3"
add_port_option "[ ] MEM_DEBUG"
add_port_option "[x] SCHEMA"
add_port_option "[x] THREADS"
add_port_option "[ ] THREAD_ALLOC"
add_port_option "[x] VALID"
add_port_option "[ ] XMLLINT_HIST"
create_port_options


# -- textproc/libxslt OPTIONS --
init_port_options "textproc_libxslt" "libxslt" "1.1.28_1"
add_port_option "[x] CRYPTO"
add_port_option "[ ] MEM_DEBUG"
create_port_options


# -- www/nginx OPTIONS --
init_port_options "www_nginx" "nginx" "1.10.2_2,2"
add_port_option "[x] DSO"
add_port_option "[ ] DEBUG"
add_port_option "[ ] DEBUGLOG"
add_port_option "[ ] FILE_AIO"
add_port_option "[x] IPV6"
add_port_option "[ ] GOOGLE_PERFTOOLS"
add_port_option "[x] HTTP"
add_port_option "[ ] HTTP_ADDITION"
add_port_option "[ ] HTTP_AUTH_REQ"
add_port_option "[x] HTTP_CACHE"
add_port_option "[x] HTTP_DAV"
add_port_option "[ ] HTTP_FLV"
add_port_option "[ ] HTTP_GEOIP"
add_port_option "[ ] HTTP_GZIP_STATIC"
add_port_option "[ ] HTTP_GUNZIP_FILTER"
add_port_option "[ ] HTTP_IMAGE_FILTER"
add_port_option "[ ] HTTP_MP4"
add_port_option "[ ] HTTP_PERL"
add_port_option "[ ] HTTP_RANDOM_INDEX"
add_port_option "[ ] HTTP_REALIP"
add_port_option "[x] HTTP_REWRITE"
add_port_option "[ ] HTTP_SECURE_LINK"
add_port_option "[ ] HTTP_SLICE"
add_port_option "[ ] HTTP_SSL"
add_port_option "[x] HTTP_STATUS"
add_port_option "[ ] HTTP_SUB"
add_port_option "[ ] HTTP_XSLT"
add_port_option "[ ] MAIL"
add_port_option "[ ] MAIL_IMAP"
add_port_option "[ ] MAIL_POP3"
add_port_option "[ ] MAIL_SMTP"
add_port_option "[ ] MAIL_SSL"
add_port_option "[ ] HTTPV2"
add_port_option "[ ] NJS"
add_port_option "[ ] STREAM"
add_port_option "[ ] STREAM_SSL"
add_port_option "[ ] THREADS"
add_port_option "[x] WWW"
add_port_option "[ ] AJP"
add_port_option "[ ] AWS_AUTH"
add_port_option "[ ] CACHE_PURGE"
add_port_option "[ ] CLOJURE"
add_port_option "[ ] CT"
add_port_option "[ ] ECHO"
add_port_option "[ ] FASTDFS"
add_port_option "[ ] HEADERS_MORE"
add_port_option "[ ] HTTP_ACCEPT_LANGUAGE"
add_port_option "[ ] HTTP_ACCESSKEY"
add_port_option "[ ] HTTP_AUTH_DIGEST"
add_port_option "[ ] HTTP_AUTH_KRB5"
add_port_option "[ ] HTTP_AUTH_LDAP"
add_port_option "[ ] HTTP_AUTH_PAM"
add_port_option "[ ] HTTP_DAV_EXT"
add_port_option "[ ] HTTP_EVAL"
add_port_option "[ ] HTTP_FANCYINDEX"
add_port_option "[ ] HTTP_FOOTER"
add_port_option "[ ] HTTP_GEOIP2"
add_port_option "[ ] HTTP_JSON_STATUS"
add_port_option "[ ] HTTP_MOGILEFS"
add_port_option "[ ] HTTP_MP4_H264"
add_port_option "[ ] HTTP_NOTICE"
add_port_option "[ ] HTTP_PUSH"
add_port_option "[ ] HTTP_PUSH_STREAM"
add_port_option "[ ] HTTP_REDIS"
add_port_option "[ ] HTTP_RESPONSE"
add_port_option "[ ] HTTP_SUBS_FILTER"
add_port_option "[ ] HTTP_TARANTOOL"
add_port_option "[ ] HTTP_UPLOAD"
add_port_option "[ ] HTTP_UPLOAD_PROGRESS"
add_port_option "[ ] HTTP_UPSTREAM_CHECK"
add_port_option "[ ] HTTP_UPSTREAM_FAIR"
add_port_option "[ ] HTTP_UPSTREAM_STICKY"
add_port_option "[ ] HTTP_VIDEO_THUMBEXTRACTOR"
add_port_option "[ ] HTTP_ZIP"
add_port_option "[ ] ARRAYVAR"
add_port_option "[ ] BROTLI"
add_port_option "[ ] DRIZZLE"
add_port_option "[ ] DYNAMIC_UPSTREAM"
add_port_option "[ ] ENCRYPTSESSION"
add_port_option "[ ] FORMINPUT"
add_port_option "[ ] GRIDFS"
add_port_option "[ ] ICONV"
add_port_option "[ ] LET"
add_port_option "[ ] LUA"
add_port_option "[ ] MEMC"
add_port_option "[ ] MODSECURITY"
add_port_option "[ ] NAXSI"
add_port_option "[ ] PASSENGER"
add_port_option "[ ] POSTGRES"
add_port_option "[ ] RDS_CSV"
add_port_option "[ ] RDS_JSON"
add_port_option "[ ] REDIS2"
add_port_option "[ ] RTMP"
add_port_option "[ ] SET_MISC"
add_port_option "[ ] SFLOW"
add_port_option "[ ] SHIBBOLETH"
add_port_option "[ ] SLOWFS_CACHE"
add_port_option "[ ] SMALL_LIGHT"
add_port_option "[ ] SRCACHE"
add_port_option "[ ] STATSD"
add_port_option "[ ] UDPLOG"
add_port_option "[ ] X11"
add_port_option "[ ] XRID_HEADER"
add_port_option "[ ] XSS"
create_port_options
