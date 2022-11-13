#!/bin/bash
#
# Checks if ntpd gets permissiong denied and then restarts ntp.

# We run hourly 
hour=`date +%k`

# add sbin cmds for init.d script of ntp
export PATH=$PATH:/sbin;

if  ( tail -n200 /var/log/daemon.log|grep $hour|grep ntpd|grep "ntpd returns a permission denied error" );then
	/etc/init.d/ntp restart;
fi;
