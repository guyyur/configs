#!/bin/sh

/usr/bin/install -c -m 0644 -o root -g wheel /dev/null /var/cache/dnsmasq-resolv.conf
/usr/bin/install -d -m 0755 -o root -g wheel /var/xdg-cache
/usr/bin/install -d -m 0700 -o guy -g guy /var/xdg-cache/guy
