#!/bin/bash

VHOME=/home/vmail

DATE=`date`;

echo "";
echo "---------------------------------------------";
echo "---- date: $DATE ----";

for FILE in `ls $VHOME/*/*/.getmail/getmailrc-*`
do
        echo "USER RCFILE: $FILE";
        UHOME=`echo $FILE | awk -F .getmail '{print$1}'`;
        export HOME=$UHOME;
        cd $HOME;

        if [ -f "$FILE" ]
        then
                sudo -u vmail getmail --rcfile $FILE -v;
        fi;
done
echo "---------------------------------------------";
