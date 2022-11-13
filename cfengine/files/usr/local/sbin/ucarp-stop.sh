#!/bin/bash
#
# This file is managed by cfengine
#
# Stops the ucarp process by a small kill.
#

# Copy args
VIP_ID=$1

# Check valid VIP_ID
if [ "$VIP_ID" == "" ]; then
        echo "No vip_id given as argument";
        exit 1;
fi;

# Find ucarp pid
UCARP_PID=`ps -ef |egrep "ucarp(.*)${VIP_ID}"|egrep -v "grep|stop"| awk '{print $2}'`;

# Check valid UCARP_PID
if [ "$UCARP_PID" == "" ]; then
        echo "No ucarp process found.";
        exit 0;
fi;

# Send kill
kill ${UCARP_PID};
