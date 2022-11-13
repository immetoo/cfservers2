#!/bin/sh
PERCENT=$1
FROM="postmaster@m4n.nl"
qwf="/tmp/quota.warning.$$"
echo "From: $FROM
To: $USER
To: postmaster@m4n.nl
Subject: Your email quota is $PERCENT% full
Content-Type: text/plain; charset="UTF-8"
Your mailbox is now $PERCENT% full." >> $qwf
cat $qwf | /usr/sbin/sendmail -f $FROM "$USER"
rm -f $qwf
exit 0
