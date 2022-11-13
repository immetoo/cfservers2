#!/bin/bash
NAME=$1
BIN=$2

# Exit codes from <sysexits.h>
EX_TEMPFAIL=75
EX_UNAVAILABLE=69

# Start processing.
if [ "$NAME" == "" ]; then
        echo "No alternative is given. E.g. editor"; exit $EX_UNAVAILABLE;
fi;
if [ "$BIN" == "" ]; then
        echo "No binary is given. E.g. /usr/bin/vim.basic"; exit $EX_UNAVAILABLE;
fi;


if [ ! -x $BIN ]; then
        echo "Binary $BIN does not exist"
     exit $EX_UNAVAILABLE;
fi

if [ `/bin/readlink /etc/alternatives/$NAME` != $BIN ]; then
        /usr/sbin/update-alternatives --set $NAME $BIN 1> /dev/null
fi