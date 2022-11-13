#!/bin/bash
#
# This file is managed by cfengine
#

BACKUP_CONF="/etc/rbackup/conf.d";
BACKUP_PASS="/etc/rbackup/.rsync-pass";
BACKUP_SKIP="/etc/rbackup/.rbackup-skip";
BACKUP_PATHS="";
BACKUP_EXCLUDES="";
SLEEP_MODE="$1";
LOG_MODE="$1";

#don't run if another call to rbackup is still running
if [ -n "`ps aux|grep rsync|egrep -v 'grep|daemon|snapshots|server'`" ]; then
		start=`ps aux|grep rsync| grep -v grep|awk {'print $9'}`;
        echo "$0 already running since $start";
        exit 0;
fi;


# don't run when we  have a skip file
# this is useful in dev environments
if [ -f "$BACKUP_SKIP" ]; then
	exit 0;
fi;

# don't run when we don't have a password file
if [ ! -f "$BACKUP_PASS" ]; then
	echo "No backup, install password file first.";
	exit 0;
fi;

# we don't want to hog the backup server so some random wait.
SLEEP="$((RANDOM%7200))";
if [ "SLEEP_MODE" == "s" ]; then
	if [ "$SLEEP" -le 432 ]; then 
		# make sleep a bit longer then ~5min.
		let SLEEP=$SLEEP+1234;
	fi;
	sleep $SLEEP;
fi;

# --delete verwijdert files op dest die op src niet aanwezig zijn.
RSYNC_OPTS="-aRqz --numeric-ids --delete --bwlimit=2000";
RSYNC_SERVER="backup0.lan.mbuyu.nl";
RSYNC_USERNAME=`hostname -s`;
RSYNC_PASSWORD=`cat $BACKUP_PASS`;
RSYNC_MODULE=$RSYNC_USERNAME;

export $SLEEP_MODE;
export $LOG_MODE;

for FILE in `ls $BACKUP_CONF/backup-*`; do
		# print logline
		if [ "$LOG_MODE" == "" ]; then
	        echo "including: $FILE";
	    fi;
	    # clear the paths.
	    BACKUP=""; 
	    EXCLUDE="";
	    EXCLUDE_FILE="";
        . $FILE;
        if [ ! "$BACKUP" == "" ]; then
                BACKUP_PATHS="$BACKUP_PATHS $BACKUP";
        fi;
        if [ ! "$EXCLUDE" == "" ]; then
        		BACKUP_EXCLUDES="$BACKUP_EXCLUDES --exclude=$EXCLUDE";
        fi;
        if [ ! "$EXCLUDE_FILE" == "" ]; then
        		BACKUP_EXCLUDES="$BACKUP_EXCLUDES --exclude-from=$EXCLUDE_FILE";
        fi;
done;

if [ "$LOG_MODE" == "" ]; then
	echo "All backup paths are: $BACKUP_PATHS";
	echo "All backup excludes are: $BACKUP_EXCLUDES";
fi;

# Do the rsync commando
RSYNC_PASSWORD=$RSYNC_PASSWORD rsync $RSYNC_OPTS $BACKUP_EXCLUDES $BACKUP_PATHS $RSYNC_USERNAME@$RSYNC_SERVER::$RSYNC_MODULE;
# exit code 24 is vanished files in rsync
if [ $? == 24 ]; then
        exit 0;
fi;

#set apart backups of M4N database of first day of month
if [ `hostname` == "mrxbak0" ]; then
	if [ `ls -al /backup/rsync/mrhpgdb4/var/backups/psql_current/m4n-backup.Fc | awk '{print $6}'|sed -r s/[0-9-]{8}//` == "01" ]; then
		cp /backup/rsync/mrhpgdb4/var/backups/psql_current/m4n-backup.Fc /backup/db_m4n/m4n-backup.Fc-`date +%F`;
		if [ -e /backup/db_m4n/m4n-backup.Fc-`date +%F` ]; then
			echo "Maandelijkse backup staat veilig in /backup/db_m4n"|mail -s "Maandelijkse backup database M4N" systeembeheer@m4n.nl;
		else
			echo "Error: er staat geen maandelijkse backup in /backup/db_m4n"|mail -s "Error: Maandelijkse backup database M4N" systeembeheer@m4n.nl;
		fi;
	else
		if [ `date +%e` == "1" ]; then 
		    echo "Geen bestand gevonden in  /backup/rsync/mrhpgdb4/var/backups/psql_current van de eerste van de maand.";
		fi;
	fi;
fi;

# normal exit
if [ $? == 0 ]; then
        exit 0;
fi;
echo "Backup failed.";
echo "cmd: $RSYNC_PASSWORD rsync $RSYNC_OPTS $BACKUP_EXCLUDES $BACKUP_PATHS $RSYNC_USERNAME@$RSYNC_SERVER::$RSYNC_MODULE;";
echo "exit-code: $?";

