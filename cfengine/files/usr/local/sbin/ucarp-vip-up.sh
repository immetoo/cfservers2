#!/bin/bash
#
# This file is managed by cfengine
#

# First bring up master interface + ip
/sbin/ifup $1:ucarp

# If there is ha proxy cfg file start it up.
if [ -e /etc/haproxy/$3.cfg ]; then
	start-stop-daemon -S -p  /var/run/haproxy.$3.pid -x /usr/sbin/haproxy  -- -f /etc/haproxy/$3.cfg  -D  -p /var/run/haproxy.$3.pid
fi;
