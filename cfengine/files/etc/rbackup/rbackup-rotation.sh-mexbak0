#!/bin/bash
#
# This file is managed by cfengine
#
# Your crontab will typically look something like this:
# 59 3 * * * /etc/rbackup-rotation.sh daily
# 58 3 * * 0 /etc/rbackup-rotation.sh weekly
# 57 3 1 * * /etc/rbackup-rotation.sh monthly

# config
src="/backup/rsync";
dst="/backup/snapshots";
unit=$1;

# Constants
daily=5
weekly=4
monthly=4

# create $unit.0 dir.
case $unit in
    daily)
            [ -d $src ] && cp -al $src/  $dst/$unit.0;
        ;;
    weekly)
            [ -d $dst/daily.$daily ] && mv $dst/daily.$daily $dst/$unit.0;
        ;;
    monthly)
            [ -d $dst/weekly.$weekly ] && mv $dst/weekly.$weekly $dst/$unit.0;
        ;;
    *)
        echo "syntax: $0 <type>";
        echo "Type may be; daily,weekly or monthly";
        exit 1
        ;;
esac

# Rotate the current list of backups, if we can.
if [ -d $dst/$unit.0 ]; then
        oldest=`ls -d $dst/$unit.* | tail -n 1 | sed 's/^.*\.//'`
        for i in `seq $oldest -1 0`; do
            mv $dst/$unit.$i $dst/$unit.$((i+1));
        done
fi

# if we've rotated the last backup off the stack, remove it.
[ -d $dst/$1.$((${!1}+1)) ] && rm -rf $dst/$1.$((${!1}+1))


#  let's make the new snapshot reflect the current date.
[ -d $dst/$1.1 ] && touch $dst/$1.1

#remove /var/logs. we only keep (rotated) logs  in /backup/rsync
rm -fr $dst/daily.1/*/var/log/*