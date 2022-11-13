#!/bin/bash
#
# 24/03/2005
# backups the tomcat logs.
# tars them and cleans them.

LOG_SOURCE="/opt/tomcat/logs";
LOG_DEST="/m4n/log/webapp";
. /m4n/bin/log_functions.sh;

DAYS=1;
if [ ! "$1" == "" ]
then
	DAYS=$1;
	echo "Doing log files of $DAYS back.";
fi;

FILE_DATE=`date --date=''$DAYS' day ago' +%Y.%m.%d`;
TOMCAT_DATE=`date --date=''$DAYS' day ago' +%Y-%m-%d`;
check_dir $LOG_DEST "" "" $DAYS;
LOG_DIR=$RETURN_PATH;

# Stop backup if no m4n log in found, TODO rewrite to something less m4n.
if [ ! -e "$LOG_SOURCE/m4n.$TOMCAT_DATE.log" ]
then
	exit 0;
fi;

echo "Starting backup of access logs.";
cd $LOG_SOURCE; # cd so ls in for loop does not include the path.
for DOMAIN in `ls *access* -1|awk -F "-access" '{print $1}'|uniq`
do

	if [ -e "$LOG_DIR/$DOMAIN-access-$FILE_DATE.tar.gz" ]
	then
		echo "ERROR: destination $LOG_DIR/$DOMAIN-access-$FILE_DATE.tar.gz file excists, skipping !"; 1>&2;
		continue;
	fi;

	echo "Creating access file of $DOMAIN";
	tar -czf $LOG_DIR/$DOMAIN-access-$FILE_DATE.tar.gz $DOMAIN-access-$FILE_DATE.*.log;

	echo "Removing access logs of $DOMAIN";
#	rm $LOG_SOURCE/$DOMAIN-access-$FILE_DATE.*.log;
done;

echo "Tar'ing and removing M4N roteted logs";
cd $LOG_SOURCE;
if [ -e "$LOG_DIR/m4n-$FILE_DATE.tar.gz" ]
then
    echo "ERROR: destination $LOG_DIR/m4n-$FILE_DATE.tar.gz file excists, skipping !";  1>&2;
else
	tar -czf $LOG_DIR/m4n-$FILE_DATE.tar.gz m4n.$TOMCAT_DATE.log;
#	rm $LOG_SOURCE/m4n.$TOMCAT_DATE.log;
fi;
		
cd $LOG_SOURCE;
if [ "$DAYS" == "1" ]
then
	echo "Tar and removing catalina.out";
	if [ -e "$LOG_DIR/catalina.out-$FILE_DATE.tar.gz" ]
	then
		echo "ERROR: destination $LOG_DIR/catalina.out-$FILE_DATE.tar.gz file excists, skipping !"; 1>%2
	else
		tar -czf $LOG_DIR/catalina.out-$FILE_DATE.tar.gz catalina.out;
		echo "Cleaning catalina.out";
		echo "" > catalina.out;
	fi;
fi;

# Removed all files we don't backup.
cd $LOG_SOURCE;
rm -f manager.20*;
rm -f host-manager.20*;
rm -f localhost.20*;
rm -f admin.20*;

