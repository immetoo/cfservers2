#!/bin/bash

# change to the absolute directory of the script enabling the usage of relative 
# paths. This is a requirement while testing on the staging platform where more
# then one database server instance is running. The script may be called with a
# extra argument: live|dev|beta|update. Omitting the argument defaults to live.

SCRIPT_DIR=$(dirname $(readlink -f $0))

# derive the SQL and LOG directories and created the LOG directory to collect
# asynchronous logging

SQL_DIR=$(readlink -f ${SCRIPT_DIR}/../sql)
LOG_DIR=$(readlink -f ${SCRIPT_DIR}/../log)
mkdir -p $LOG_DIR

# include m4n specific script configuration from file and verify we are running
# this script on the correct host and against the correct database. For testing
# purposes we have an override: SKIP_HOSTNAME_CHECK that enables testing on the
# staging platform.

STAGE=$1

if [ "$STAGE" == "" -o "$STAGE" == "live" ]
then
    if [ -e /etc/m4n-scripts.conf ] 
    then
        . /etc/m4n-scripts.conf
        STAGE="live"
    else
        echo "live configuration file not accessible"
        exit 1
    fi
else 
    if [ -e /etc/m4n-scripts-${STAGE}.conf ]
    then 
        . /etc/m4n-scripts-${STAGE}.conf
    else 
        echo "$STAGE configuration file not accessible"
        exit 1
    fi
fi

if [ 'mrhpgdb4' != `hostname` ]
then
    if [ "$SKIP_HOSTNAME_CHECK" != "true" ]
    then
        echo "Not the live database host, script will exit!"
        exit 1
    fi
fi


# function to iterate and execute all sql files in BASE_DIR to target database
function executeSQLFilesInBaseDir {
    BASE_DIR=$1
    DESCRIPTION=$2
    
    if [ "$DESCRIPTION" != "" ]
    then 
        echo -e "\n$DESCRIPTION:" 
    fi  
    
    if [ `ls $BASE_DIR | grep -E ^.*\.sql$ | wc -l` -eq 0 ] 
    then
        echo -e "\nNo sql files in $BASE_DIR"
        return
    fi

    # the maximum number of background processes 
    MAX_JOBS=32
    # variable used to iterate through the array of background processes
    JOB=0

    # preset the array of background processes to 0, indicating an idle state
    while [ $JOB -lt $MAX_JOBS ]
    do
        JOB_PID[$JOB]=0
        JOB=$(( $JOB + 1 ))
    done    

    # empty the LOG directory
    rm -f $LOG_DIR/*.sql
	
    # iterate the sql files in given directory and execute non empty files
    JOB=0
    for FILE in `ls $BASE_DIR | grep -E ^.*\.sql$` 
    do
        while true
        do 
            if [ ${JOB_PID[$JOB]} -eq 0 ]
            then 
                if [ -s $BASE_DIR$FILE ] 
                then
                    echo -e "\n$BASE_DIR$FILE:" > $LOG_DIR/$FILE
                    cat $BASE_DIR$FILE | /usr/bin/time -f "execution time in seconds: %e" psql -h $DB_HOST -U $DB_USER $DB_NAME >> $LOG_DIR/$FILE 2>&1 &
                    JOB_PID[$JOB]=$(( $! )) 
                    JOB=$((( $JOB + 1 ) % $MAX_JOBS ))
                fi
                break
            fi	

            if [ -d /proc/${JOB_PID[$JOB]} ]
            then
                JOB=$((( $JOB + 1 ) % $MAX_JOBS ))
                sleep 1
            else 
                JOB_PID[$JOB]=0
            fi
        done   
    done

    # wait for all background processes to be finished
    FINISHED=0
    while true
    do	
        JOB=$((( $JOB + 1 ) % $MAX_JOBS ))
        if [ $JOB -eq 0 ] 
        then
            if [ $FINISHED -eq $MAX_JOBS ] 
            then
                for FILE in `ls $LOG_DIR` 
                do 
                	cat $LOG_DIR/$FILE
                done
                break 
            else
                FINISHED=0
                sleep 1
            fi
        fi 

        if [ ${JOB_PID[$JOB]} -ne 0 ]
        then   
            if [ ! -d /proc/${JOB_PID[$JOB]} ]
            then
                JOB_PID[$JOB]=0
            fi
        else 
            FINISHED=$(( $FINISHED + 1 ))
        fi
    done
}


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


# function to execute a sql QUERY to target database
function executeSQL {
    QUERY=$1
    DESCRIPTION=$2
    
    if [ "$DESCRIPTION" != "" ]
    then 
        echo -e "\n$DESCRIPTION:" 
    fi  
   
    echo -e "\n$QUERY:" 
    echo "$QUERY" | /usr/bin/time -f "execution time in seconds: %e" psql -h $DB_HOST -U $DB_USER $DB_NAME
}


echo -e "\n\nScript environment: host = $DB_HOST - user = $DB_USER - database = $DB_NAME."

# maintenance_queries will be executed unordered
echo -e "\nmaintenance queries"
echo -e   "###################"
executeSQLFilesInBaseDir "$SQL_DIR/maintenance/"

# daltons queries will be executed ordered and unordered
echo -e "\ndalton queries"
echo -e   "##############"
executeSQLFilesInBaseDir "$SQL_DIR/daltons/"
executeSQLFile "$SQL_DIR/daltons/flush/daltons_flush_rejected.sql"

# affiliate queries will be executed unordered
echo -e "\naffiliate queries"
echo -e   "#################"
executeSQLFilesInBaseDir "$SQL_DIR/affiliate/"

# merchant queries will be executed unordered
echo -e "\nmerchant queries"
echo -e   "################"
executeSQLFilesInBaseDir "$SQL_DIR/merchant/"

# recalculate click and lead rewards
echo -e "\ncost and reward recalculation query"
echo -e   "###################################"
executeSQLFilesInBaseDir "$SQL_DIR/rewards/"

# First day of the year? Reset the creditor invoice numbers to YYYY0000000000001
if [ $(date +%d%m) == 0101 ]
then
	echo -e "\nResetting invoice number sequence"
	echo -e "#################################"
        executeSQL "SELECT setval('history.creditor_invoice_number_seq', (extract(year from now()) * 10000000000000)::bigint)"
fi
  	
# paypid made sure its only runs once
paypid="/var/run/m4n-payment-${STAGE}.pid"
if [ $(date +%d) == 01 ]
then
    if [ -f $paypid ]
    then
        echo -e "\nskipping payment"
        echo -e   "################"
    else
        echo "$$" > $paypid
        echo -e "\nstarting payment query"
        echo -e   "######################"
      
        YEAR=`date +%Y`
        MONTH=`date +%m`
        DAY="01"
        YEAR_NEXT_PAYMENT=`date --date '+1 month' +%Y`
        MONTH_NEXT_PAYMENT=`date --date '+1 month' +%m`
			
        echo -e "\ncurrent payment_period is: $DAY-$MONTH-$YEAR on $DB_USER@$DB_HOST:$DB_NAME"
        echo -e "\nnext payment_period will be: $DAY-$MONTH_NEXT_PAYMENT-$YEAR_NEXT_PAYMENT on $DB_USER@$DB_HOST:$DB_NAME"

        # update current payment period and create next unprocessed payment period 
        executeSQL "UPDATE payment_period SET description = 'm4n_payment_$YEAR-$MONTH-$DAY' WHERE processed = false;" "set process timestamp for current payment_period"
        executeSQL "INSERT INTO payment_period (description,end_date,start_date) VALUES ('next m4n payment','$YEAR_NEXT_PAYMENT-$MONTH_NEXT_PAYMENT-$DAY 00:00:00','$YEAR-$MONTH-$DAY 00:00:00');" "create next payment_period"

        # move views, clicks and leads to the next payment period
        executeSQL "UPDATE click SET payment_period_id = (SELECT max(id) FROM payment_period) WHERE payment_period_id != (SELECT max(id) FROM payment_period) AND created > '$YEAR-$MONTH-$DAY 00:00:00'; UPDATE click SET payment_period_id = (SELECT max(id) FROM payment_period) WHERE status IN ('TO_BE_APPROVED','ON_HOLD');" "set next payment period on click"
        executeSQL "UPDATE view SET payment_period_id = (SELECT max(id) FROM payment_period) WHERE payment_period_id != (SELECT max(id) FROM payment_period) AND created > '$YEAR-$MONTH-$DAY 00:00:00'; UPDATE view SET payment_period_id = (SELECT max(id) FROM payment_period) WHERE status IN ('TO_BE_APPROVED','ON_HOLD');" "set next payment period on view"
        executeSQL "UPDATE lead SET payment_period_id = (SELECT max(id) FROM payment_period) WHERE payment_period_id != (SELECT max(id) FROM payment_period) AND created > '$YEAR-$MONTH-$DAY 00:00:00'; UPDATE lead SET payment_period_id = (SELECT max(id) FROM payment_period) WHERE status IN ('TO_BE_APPROVED','ON_HOLD');" "set next payment period on lead"
    fi
fi

# remove paypid on 2nd so it wil run again on 1st
if [ $(date +%d) == 02 ]
then
    if [ -f $paypid ]
    then
        rm -f $paypid
    fi
fi

# automatically set approval status on 28th
if [ $(date +%d) == 28 ]
then
    echo -e "\napproval queries"
    echo -e   "################"
    executeSQLFile "$SQL_DIR/approval/leads_on_hold_for_merchants.sql" "put leads on hold for specified merchants"
    executeSQLFile "$SQL_DIR/approval/accept_leads_one_month_old.sql" "accept one month old leads if merchant is too reluctant to it him/herself"
fi

# calculating statistics ordered and unordered
echo -e "\nstatistics queries"
echo -e   "##################"
executeSQLFile           "$SQL_DIR/statistics/rows_to_be_updated/rows_to_be_updated.sql"
executeSQLFilesInBaseDir "$SQL_DIR/statistics/rows_to_be_updated/indices/"
executeSQLFilesInBaseDir "$SQL_DIR/statistics/rows_to_be_updated/vacuum/"
executeSQLFilesInBaseDir "$SQL_DIR/statistics/statistics_per_day/concurrent/"
executeSQLFile           "$SQL_DIR/statistics/statistics_per_day/statistics_per_day.sql"
executeSQLFilesInBaseDir "$SQL_DIR/statistics/derived_statistics/"

# calculate invoices if a new payment_period has been created and statistics have been calculated
if [ -f $paypid ]
then
    # TODO: quick hack to close payment period after all statistics have been calculated
    executeSQL "UPDATE payment_period SET processed = true WHERE id = (SELECT min(id) FROM payment_period WHERE processed = false);" "set current payment_period to processed"
    echo -e "\ninvoice queries"
    echo -e   "###############"
    executeSQLFilesInBaseDir "$SQL_DIR/invoice/"   
fi

# dynamically generate all vacuum queries to secure database performance
echo -e "\nvacuum queries"
echo -e   "##############"
mkdir -p $SQL_DIR/maintenance/vacuum
rm -f $SQL_DIR/maintenance/vacuum/*.sql
tables_to_vacuum=`echo "SELECT nspname || '.' || relname FROM pg_class LEFT JOIN pg_user ON pg_user.usesysid = pg_class.relowner LEFT JOIN pg_namespace ON pg_namespace.oid = pg_class.relnamespace WHERE relkind = 'r' AND nspname NOT IN ('pg_catalog', 'pg_toast', 'information_schema') ORDER BY nspname, relname;" | psql -h $DB_HOST -U $DB_USER $DB_NAME -tA`
for t in $tables_to_vacuum
do
    echo "VACUUM ANALYZE ${t};" > $SQL_DIR/maintenance/vacuum/vacuum_analyze_${t}.sql
done 
executeSQLFilesInBaseDir "$SQL_DIR/maintenance/vacuum/"
