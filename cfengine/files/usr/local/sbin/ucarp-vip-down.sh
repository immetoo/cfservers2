#!/bin/bash
#
# This file is managed by cfengine
#

# If there is ha proxy cfg file stop it.
if [ -e /etc/haproxy/$3.cfg ]; then
	start-stop-daemon -K -p  /var/run/haproxy.$3.pid -x /usr/sbin/haproxy  -- -f /etc/haproxy/$3.cfg  -D  -p /var/run/haproxy.$3.pid
fi;

 # Last bring down master interface + ip
/sbin/ifdown $1:ucarp
