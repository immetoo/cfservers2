#!/bin/bash
#
# Checks if snmpd does not get OOM and then restarts snmpd.

# We run hourly 
hour=`date +%k`

# add sbin cmds for init.d script of snmpd
export PATH=$PATH:/sbin;

if  ( tail -n200 /var/log/daemon.log|grep $hour|grep snmpd|grep "Cannot allocate memory" );then
	/etc/init.d/snmpd restart;
fi;
