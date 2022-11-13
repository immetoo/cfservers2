#! /bin/bash

#####################################################
#Program to make an offsite backup 
#       from Cyso A'dam to Bit Ede
#Created: 2010-09-15
#Version: 1.4              
#Revised: 2011-03-02
#Revised by: Tijn Lambrechtsen
#Author: Paul Wiebes
#Changelog:
#0.1:	Initial script 
#1.0:	Added bandwidth limit 90KBps
#1.1:	Changed bandwidth limit from 90KBps to 400KBps ~ 3.3Mbps
#		since backups were not completed in time
#1.2:	Changed bandwidth limit from 400KBps to 800KBps ~ 6.6Mbps
#		since backups were not completed in time
#1.3:	Added --password-file option
#1.4:	Changed bandwidth limit from 800KBps to 366KBps ~ 3Mbps
#		(Asked Klaas to sign new contract. Reply: no real need yet)
#
# rsync -avz --bwlimit=400 --password-file=/etc/rbackup/.rsync-pass /backup/db_m4n rsync@mexbak0.dmz.bit.mbuyu.com:/backup;
#####################################################


if [ -z "`ps aux|grep rsync|grep -v grep|grep -v daemon`" ]; then
        rsync -avz --bwlimit=366 --password-file=/etc/rbackup/.rsync-pass /backup/rsync cyso2bit@mexbak0.dmz.bit.mbuyu.com::cyso2bit;
fi
