#!/bin/sh

/usr/bin/install -d -m 0755 -o root -g wheel /var/db/samba
/usr/bin/install -d -m 0700 -o root -g wheel /var/db/samba/private
/usr/bin/install -c -m 0700 -o root -g wheel /etc/local/samba/private/passdb-backup.tdb /var/db/samba/private/passdb.tdb
/usr/bin/install -d -m 0700 -o guy -g guy /var/log/guy
/usr/bin/install -d -m 0755 -o guy -g guy /var/log/guy/nginx
/usr/bin/install -d -m 0755 -o root -g wheel /var/log/nginx
/usr/bin/install -d -m 0755 -o root -g wheel /var/log/samba
/usr/bin/install -d -m 0755 -o root -g wheel /var/xdg-cache
/usr/bin/install -d -m 0700 -o guy -g guy /var/xdg-cache/guy
