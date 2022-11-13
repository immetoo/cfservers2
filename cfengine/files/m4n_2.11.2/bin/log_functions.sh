#!/bin/bash
#
# Some function which are handy for all log scripts.
# 
# This file is managed by cfengine

# Check if an log directory exists else it will be created.
# $1 - The base path
# $2 - (optional) YEAR else current year is used.
# $3 - (optional) MONTH else current month is used.
# $4 - (optional) DAYS back to used default == 0.
# returns in RETURN_PATH the directory to put the file into.
check_dir()
{
	if [ ! -d "$1" ]
	then
		echo "No base directory given.";
		exit 0;
	fi;

	CD_DAYS=10;
	if [ ! "$4" == "" ]
	then
		CD_DAYS=$4;
	fi;

	CD_YEAR=`date +%Y --date=''$CD_DAYS' day ago'`;
	if [ ! "$2" == "" ]
	then
		CD_YEAR=$2;
	fi;
	
	CD_M=`date +%-m --date=''$CD_DAYS' day ago'`
	if [ ! "$3" == "" ]
	then
		CD_M=$3;
	fi;
	
	CD_MONTH=`date --date=''$CD_M'/01/'$CD_YEAR'' +%B | tr [:upper:] [:lower:]`;
	CD_FMONTH=`date --date=''$CD_M'/01/'$CD_YEAR'' +%m`;
	
	RETURN_PATH=$1/$CD_YEAR/$CD_FMONTH-$CD_MONTH;
	
	if [ ! -d "$RETURN_PATH" ]
	then
		mkdir -p $RETURN_PATH;
	fi;
}


# Moves a file the the log directory
# $1 - the base directroy.
# $2 - the files to move.
# $3 - (optional) YEAR else current year is used.
# $4 - (optional) MONTH else current month is used.
do_move()
{
	check_dir $1 $3 $4;
	DM_FILE_PATH=$RETURN_PATH;
	
	if [ "$2" == "" ]
	then
		echo "No files to move.";
		exit 0;
	fi;
	
	mv $2 $DM_FILE_PATH;
}

