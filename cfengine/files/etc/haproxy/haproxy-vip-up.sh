#!/bin/sh
#
# This file is managed by cfengine
#
#
/sbin/ifup $1:ucarp
start-stop-daemon -S -p  /var/run/haproxy.$3.pid -x /usr/sbin/haproxy  -- -f /etc/haproxy/$3.cfg  -D  -p /var/run/haproxy.$3.pid
