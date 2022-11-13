#!/bin/bash

# This file should be managed by cfengine but is currently not. It should be 
# placed in /m4n/bin on mrhpgdb3 where cron invokes it at 07:00, 13:00 and 
# 19:00 hours.

# Database backup script dumps and restores production databases on a separate 
# server and increases sequences with a value that allows disaster recovery. It
# automatically tests whether the dumps from the database are valid, in other 
# words: is a dump restorable?

if [ 'mrhpgdb3' != `hostname` ]
then
    if [ "${SKIP_HOSTNAME_CHECK}" != "true" ]
    then
        echo "Not a backup DB host, script will exit!"
        exit 1
    fi
fi

# use the crosslink interface to offload the vlan network
postgresql_source_hostname="10.0.0.4"
postgresql_source_username="postgres"
postgresql_target_hostname="localhost"
postgresql_target_username="postgres"
target_backup_dir="/var/backups/"
dump_args="-Fc"
restore_args="-Fc -j8"
cluster_version=8.4
cluster_name=main
max_backup_interval_in_hours=6

# Create statistics database where all sequences are stored for logging 
# purposes and estimation of sequence increments to anticipate a source
# database outage. 
if [ "`echo "SELECT datname FROM pg_database WHERE datname = 'statistics';" | psql -h ${postgresql_target_hostname} -U ${postgresql_target_username} -tA`" == "" ] 
then
    echo -e "\nCreate statistics database to log sequence data.\n"
    createdb -U $postgresql_target_username -h $postgresql_target_hostname -O mbuyu statistics
    echo "CREATE TABLE sequence (database_schema_sequence TEXT, value BIGINT, sample_time TIMESTAMP WITHOUT TIME ZONE, increments_per_second NUMERIC); CREATE INDEX sequence_database_schema_sequence_idx ON sequence (database_schema_sequence); ALTER TABLE sequence OWNER TO mbuyu;" | psql -U ${postgresql_target_username} -h ${postgresql_target_hostname} -e -q -d statistics > /dev/zero
    # DEBUG QUERY: select * from sequence order by database_schema_sequence, sample_time asc
fi
    
# DEBUG EXCLUSIONS: source_database_exclusions="'template0', 'template1', 'postgres', 'm4n', 'm4n_log', 'datafeeds'"
source_database_exclusions="'template0', 'template1', 'postgres'"
source_databases_to_backup=`echo "SELECT datname FROM pg_database WHERE datname NOT IN (${source_database_exclusions}) ORDER BY datname;" | psql -h ${postgresql_source_hostname} -U ${postgresql_source_username} -tA`

echo -e "Databases to backup:\n${source_databases_to_backup}"

# sequentially dump, restore and swap all source databases to backup
for i in ${source_databases_to_backup}
do	
    #############
    # LOG EVENT #
    ############# 
    echo -e "\nStart backup script for database ${i} on `date`"
	
    ########
    # DUMP #
    ########
    echo -e "Dump database"	
    start_time=`date '+%s'`
    dump_file="${target_backup_dir}/${i}-backup.Fc"
    
    if [ -f ${dump_file} ] 
    then 
        rm ${dump_file}
    fi
    
    pg_dump ${dump_args} -U ${postgresql_source_username} -h ${postgresql_source_hostname} ${i} > $dump_file
    finish_time=`date '+%s'`
    duration=`expr ${finish_time} - ${start_time}`
    echo -e "Dumping database completed in ${duration} seconds"	
    
    ###########
    # RESTORE #
    ###########
    echo -e "Restore database"	
    start_time=`date '+%s'`
    dump_file="${target_backup_dir}/${i}-backup.Fc"
    owner=`echo "SELECT usename FROM pg_shadow WHERE usesysid = (SELECT datdba FROM pg_database WHERE datname = '${i}');" | psql -h ${postgresql_source_hostname} -U ${postgresql_source_username} -tA`
    
    if [ "`echo "SELECT datname FROM pg_database WHERE datname = '${i}_restored';" | psql -h ${postgresql_target_hostname} -U ${postgresql_target_username} -tA`" != "" ] 
    then
        dropdb -U ${postgresql_target_username} -h ${postgresql_target_hostname} ${i}_restored
    fi
    
    createdb -U ${postgresql_target_username} -h ${postgresql_target_hostname} -O ${owner} ${i}_restored
    pg_restore ${restore_args} -U ${postgresql_target_username} -h ${postgresql_target_hostname} -d ${i}_restored $dump_file
    
    finish_time=`date '+%s'`
    duration=`expr ${finish_time} - ${start_time}`
    echo -e "Restoring database completed in ${duration} seconds"	
       
    ########
    # SWAP #
    ########
    echo -e "Swap database;"	
    start_time=`date '+%s'`
    
    echo "ALTER DATABASE ${i} RENAME TO ${i}_old;" | psql -U ${postgresql_target_username} -h localhost -e -q
    echo "ALTER DATABASE ${i}_restored RENAME TO ${i};" | psql -U ${postgresql_target_username} -h localhost -e -q
    dropdb -U ${postgresql_target_username} -h localhost ${i}_old
    
    finish_time=`date '+%s'`
    duration=`expr ${finish_time} - ${start_time}`
    echo -e "Swapping database completed in ${duration} seconds"
    
    #############
    # SEQUENCES #
    #############
    
    echo -e "Sync sequences;"	
    start_time=`date '+%s'`

    sequences_to_maintain=`echo "SELECT nspname || '.' || relname FROM pg_class LEFT JOIN pg_user ON pg_user.usesysid = pg_class.relowner LEFT JOIN pg_namespace ON pg_namespace.oid = pg_class.relnamespace WHERE relkind = 'S' AND nspname NOT IN ('pg_catalog', 'pg_toast', 'information_schema') ORDER BY nspname, relname;" | psql -h ${postgresql_source_hostname} -U ${postgresql_source_username} -tA -d ${i}`
    for j in ${sequences_to_maintain}
    do 
        # Get the sequence value from source database
        value=`echo "SELECT last_value FROM ${j};" | psql -h ${postgresql_source_hostname} -U ${postgresql_source_username} -tA -d ${i}`    
        
        # And insert the sequence value in the statistics database sequence table
        # where increments_per_second is calculated like:
        # (value - value[t-1])::NUMERIC / (now() - sample_time[t-1])::SECONDS   
        database_schema_sequence="${i}.${j}"
        echo "INSERT INTO sequence (database_schema_sequence, value, sample_time, increments_per_second) VALUES ('${database_schema_sequence}', ${value}, now(), ((${value} - coalesce((SELECT value FROM sequence WHERE database_schema_sequence='${database_schema_sequence}' ORDER BY sample_time DESC LIMIT 1), ${value}))::NUMERIC) / (extract(epoch FROM now()) - coalesce(extract(epoch FROM (SELECT sample_time FROM sequence WHERE database_schema_sequence='${database_schema_sequence}' ORDER BY sample_time DESC LIMIT 1)), 0)));" | psql -h ${postgresql_target_hostname} -U ${postgresql_target_username} -e -q -d statistics > /dev/zero
        
        # Now update the target database sequences with the highest number of 
        # increments per second anticipating the max_backup_interval_in_hours
        # with a safety margin of 2.
        anticipated_value=`echo "SELECT (${value} + round((2 * ${max_backup_interval_in_hours} * 3600)::NUMERIC * (SELECT max(increments_per_second) FROM sequence WHERE database_schema_sequence='${database_schema_sequence}')));" | psql -h ${postgresql_target_hostname} -U ${postgresql_target_username} -tA -d statistics`
        
        # If the current value equals the anticipated value no statistics info 
        # has been collected yet, in that case double the sequence.
        if [ "${anticipated_value}" == "${value}" ] 
        then 
            anticipated_value=`expr 2 \* ${value}`
        fi
        
        echo "SELECT '${database_schema_sequence}: current_value=${value}, anticipated_value=' || setval('${j}', ${anticipated_value});" | psql -U ${postgresql_target_username} -h ${postgresql_target_hostname} -tA -d ${i}
    done
    
    finish_time=`date '+%s'`
    duration=`expr ${finish_time} - ${start_time}`
    echo -e "Syncing sequences completed in ${duration} seconds"
  
done

