#!/bin/sh

/usr/bin/install -d -m 0755 -o root -g wheel /var/db/dhcpcd
/usr/bin/install -c -m 0644 -o root -g wheel /etc/local/dhcpcd.duid.backup /var/db/dhcpcd/duid
/usr/bin/install -c -m 0600 -o root -g wheel /etc/local/dhcpcd.secret.backup /var/db/dhcpcd/secret
/usr/bin/install -d -m 0700 -o guy -g guy /var/tmp/guy
/usr/bin/install -d -m 0755 -o root -g wheel /var/xdg-cache
/usr/bin/install -d -m 0700 -o root -g wheel /var/xdg-cache/root
/usr/bin/install -d -m 0700 -o guy -g guy /var/xdg-cache/guy
