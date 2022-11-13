#!/bin/bash

maxtap=5;

if [ ! -d "/dev/net" ]; then
	mkdir /dev/net
fi;

# Creat the tunnel interfaces
echo -n "OpenVPN: Creating TUN interfaces:";
for i in `seq 1 ${maxtap}`; do
   openvpn --mktun --dev tap${i};
   echo -n ".";
done
echo "";

# Create the bridges for each tap
# echo -n "OpenVPN: Creating bridge TAP interfaces:";
# for i in `seq 0 ${maxtap}`; do
#    brctl addif br0 tap${i};
#    echo -n ".";
# done
# echo "";