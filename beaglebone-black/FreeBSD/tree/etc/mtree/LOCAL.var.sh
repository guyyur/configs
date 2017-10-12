#!/bin/sh

/usr/bin/install -d -m 0700 -o guy -g guy /var/log/guy
/usr/bin/install -d -m 0755 -o guy -g guy /var/log/guy/nginx
/usr/bin/install -d -m 0755 -o root -g wheel /var/log/nginx
/usr/bin/install -d -m 0755 -o root -g wheel /var/xdg-cache
/usr/bin/install -d -m 0700 -o guy -g guy /var/xdg-cache/guy
