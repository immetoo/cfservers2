#!/bin/bash
# This script copies prices that are put in description2 into the correct price field.

# include m4n specific script configuration from file
. /etc/m4n-scripts.conf

# make sure we only can run on main database machines but enable a test mode setting

if [ 'mrhpgdb4' != `hostname` ]
then
    if [ "$SKIP_HOSTNAME_CHECK" != "true" ]
    then
        echo "Not a main DB host, script will exit!"
        exit 1
    fi
fi


# function to execute a sql FILE to target database
function executeSQLFile {
    FILE=$1
    DESCRIPTION=$2
   
    if [ "$DESCRIPTION" != "" ]
    then 
        echo -e "\n$DESCRIPTION:" 
    fi  
    
    echo -e "\n$FILE:" 
    cat $FILE | /usr/bin/time -f "execution time in seconds: %e" psql -h $DB_HOST -U $DB_USER $DB_NAME
}

# Recalculate lead rewards for leads modified by merchant or affiliate queries
echo -e "\nlead cost and reward recalculation query"
echo -e   "########################################"
executeSQLFile "/m4n/sql/rewards/recalculate_lead_rewards.sql"