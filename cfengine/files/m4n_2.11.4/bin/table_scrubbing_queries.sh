#!/bin/bash

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

    # create a temporary log directory to collect asynchronous logging
    TEMP_DIR=/tmp/table_scrubbing_queries/log/
    mkdir -p $TEMP_DIR
    rm -rf $TEMP_DIR*
	
    # iterate the sql files in given directory
    JOB=0
    for FILE in `ls $BASE_DIR | grep -E ^.*\.sql$` 
    do
        while true
        do 
            if [ ${JOB_PID[$JOB]} -eq 0 ]
            then 
                echo -e "\n$BASE_DIR$FILE:" > $TEMP_DIR$FILE
                cat $BASE_DIR$FILE | /usr/bin/time -f "execution time in seconds: %e" psql -h $DB_HOST -U $DB_USER $DB_NAME >> $TEMP_DIR/$FILE 2>&1 &
                JOB_PID[$JOB]=$(( $! )) 
                JOB=$((( $JOB + 1 ) % $MAX_JOBS ))
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
                for FILE in `ls $TEMP_DIR` 
                do 
                	cat $TEMP_DIR$FILE
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

echo -e "Script Start"
echo -e "############"

echo -e "\nmaintenance queries"
echo -e   "###################"

executeSQLFile           "/m4n/sql/maintenance/table_scrubbing/click/create_raw_filtered_copy.sql"
executeSQLFilesInBaseDir "/m4n/sql/maintenance/table_scrubbing/click/indices/"
executeSQLFilesInBaseDir "/m4n/sql/maintenance/table_scrubbing/click/constraints/"
executeSQLFile           "/m4n/sql/maintenance/table_scrubbing/click/vacuum_full_freeze_analyze_copy.sql"
executeSQLFile           "/m4n/sql/maintenance/table_scrubbing/click/synchronize_and_swap_copy.sql"

executeSQLFile           "/m4n/sql/maintenance/table_scrubbing/dart_vars/create_raw_filtered_copy.sql"
executeSQLFilesInBaseDir "/m4n/sql/maintenance/table_scrubbing/dart_vars/indices/"
executeSQLFile           "/m4n/sql/maintenance/table_scrubbing/dart_vars/vacuum_full_freeze_analyze_copy.sql"
executeSQLFile           "/m4n/sql/maintenance/table_scrubbing/dart_vars/synchronize_and_swap_copy.sql"

executeSQLFile           "/m4n/sql/maintenance/table_scrubbing/view/create_raw_filtered_copy.sql"
executeSQLFilesInBaseDir "/m4n/sql/maintenance/table_scrubbing/view/indices/"
executeSQLFilesInBaseDir "/m4n/sql/maintenance/table_scrubbing/view/constraints/"
executeSQLFile           "/m4n/sql/maintenance/table_scrubbing/view/vacuum_full_freeze_analyze_copy.sql"
executeSQLFile           "/m4n/sql/maintenance/table_scrubbing/view/synchronize_and_swap_copy.sql"

/usr/bin/time -f "execution time in seconds: %e" pg_dump -h $DB_HOST -U $DB_USER $DB_NAME -Fc -t click_old -f /var/backups/psql_current/click-backup.Fc
/usr/bin/time -f "execution time in seconds: %e" pg_dump -h $DB_HOST -U $DB_USER $DB_NAME -Fc -t dart_vars_old -f /var/backups/psql_current/dart_vars-backup.Fc
/usr/bin/time -f "execution time in seconds: %e" pg_dump -h $DB_HOST -U $DB_USER $DB_NAME -Fc -t view_old -f /var/backups/psql_current/view-backup.Fc

#executeSQLFile           "/m4n/sql/maintenance/table_scrubbing/click/drop_old.sql"
#executeSQLFile           "/m4n/sql/maintenance/table_scrubbing/dart_vars/drop_old.sql"
#executeSQLFile           "/m4n/sql/maintenance/table_scrubbing/view/drop_old.sql"


echo -e "\nScript End"
echo -e   "##########"
 
