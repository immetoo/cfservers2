#!/bin/bash

if [ "$1" == "" ]
then
        echo "Use with dest-hostname as argument.";
        exit 1;
fi

HOST=$1;
HOST_IP=`host $HOST|awk '{if ($2=="A") print $3}'|head -n1`;

if [ "$HOST_IP" == "" ]
then
        echo "Could not resolv hostname: $HOST";
        exit 1;
fi


echo "";
echo "This script will install cfengine2 on: $HOST ip: $HOST_IP";
echo "";

echo "Installing cfe2:";
echo "apt-get update;apt-get -y install cfengine2" | ssh root@$HOST /bin/bash

echo "Installing keys";
cd /var/lib/cfengine2/ppkeys/
scp root@$HOST:/var/lib/cfengine2/ppkeys/localhost.pub root-$HOST_IP.pub
scp localhost.pub root@$HOST:/var/lib/cfengine2/ppkeys/root-172.16.21.131.pub		
cd /etc/cfengine/
scp /var/lib/cfengine2/files/etc/cfengine/update.conf-client root@$HOST:/etc/cfengine/update.conf
scp /var/lib/cfengine2/files/etc/cfengine/cfservd.conf-client root@$HOST:/etc/cfengine/cfservd.conf
echo "Done.";