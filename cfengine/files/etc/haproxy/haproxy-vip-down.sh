#!/bin/bash
#
# This file is managed by cfengine
#
#
start-stop-daemon -K -p  /var/run/haproxy.$3.pid -x /usr/sbin/haproxy  -- -f /etc/haproxy/$3.cfg  -D  -p /var/run/haproxy.$3.pid
/sbin/ifdown $1:ucarp