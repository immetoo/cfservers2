#!/bin/bash

TMP="/tmp/mail-apt-upgrades.$$";
apt-get -f -s upgrade | egrep "Inst|Remv" >> $TMP

PACKAGES=`cat $TMP`;
if [  -z "$PACKAGES" ]; then
	rm -rf $TMP
	exit 0;
fi;

echo -e "\n\nThis are all packages to be upgraded by apt-get.\n" >> $TMP
echo -e "hostname: "`hostname -f` >> $TMP
echo -e "\n Generated by: $0\n" >> $TMP

cat $TMP;
rm -rf $TMP;
exit 0;
