#!/bin/bash

# Set the input data
REQ_TYPE=$2;
REQ_OID=$3;
REQ_BASE=$1;
REQ_STEP=`echo $REQ_OID|awk -F. '{print $NF}'`;

# clean up on exit
trap "rm /tmp/aps.$$" 0 1 2 3 15

# get temp file
wget -q -O- "http://localhost/server-status?auto" > /tmp/aps.$$;

# normal values
# 0 = Total Accesses: 17
# 1 = Total kBytes: 7
# 2 = CPULoad: 1.94207e-5
# 3 = Uptime: 617898
# 4 = ReqPerSec: 2.75126e-5
# 5 = BytesPerSec: .0116006
# 6 = BytesPerReq: 421.647
# 7 = BusyWorkers: 1
# 8 = IdleWorkers: 4
# score bord values
# 9 = waiting
# 10 = starting up
# 11 = reading request
# 12 = sending reply
# 13 = keepalive
# 14 = DNS lookup
# 15 = closing connection
# 16 = logging
# 17 = graceful finishing
# 18 = idle cleanup
# 19 = open slot

# init all data on zero
for ((i=0; i <= 19 ; i++));do
        DATA[$i]=0;
done;

while read line
        do a=$(($a+1));
        dot=`expr index "$line" ':'`;
        let dot=$dot+1;
        value=${line:$dot};
        case "$line" in
        *Accesses*) DATA[0]=$value;;
        *kBytes*) DATA[1]=$value;;
        CPULoad*) DATA[2]=$value;;
        Uptime*) DATA[3]=$value;;
        ReqPerSec*) DATA[4]=$value;;
        BytesPerSec*) DATA[5]=$value;;
        BytesPerReq*) DATA[6]=$value;;
        BusyWorkers*) DATA[7]=$value;;
        IdleWorkers*) DATA[8]=$value;;
        Scoreboard*)
        		if [ "$REQ_STEP" -lt 9 ];then
                        continue; # only calculate , when asked.
                fi;
                count=${#value};
                for ((i=0; i <= $count ; i++));do
                        char=${value:$i:1};
                        index=0;
                        case "$char" in
                        "_") index=9;;
                        "S") index=10;;
                        "R") index=11;;
                        "W") index=12;;
                        "K") index=13;;
                        "D") index=14;;
                        "C") index=15;;
                        "L") index=16;;
                        "G") index=17;;
                        "I") index=18;;
                        ".") index=19;;
                        *)continue;;
                        esac
                        let tmpcount=${DATA[$index]}+1;
                        DATA[$index]=$tmpcount;
                done;
                ;;
        *);;
        esac
done < /tmp/aps.$$

# print all data
#i=0;
#for D in ${DATA[@]};do
#        echo "DATA: $i = $D";
#        let i=$i+1;
#done;

function printSNMP() {
        echo "$REQ_BASE.$REQ_STEP";
        echo "integer";

        data="${DATA[$REQ_STEP]}";
        if [ "" == "$data" ];then
                data="0";
        fi
        echo "$data";
}

if [[ "-g" == "$REQ_TYPE" ]]; then
        if [[ $REQ_BASE == $REQ_OID ]];then
                exit;
        fi;
        if [[ "$REQ_STEP" -gt 19 ]]; then
                exit;
        fi;
        printSNMP;
fi;
if [[ "-n" == "$REQ_TYPE" ]]; then
        if [[ "$REQ_BASE" == "$REQ_OID" ]];then
                REQ_STEP=-1;
        fi;
        if [[ "$REQ_STEP" -gt 18 ]]; then
                exit;
        fi;
        let REQ_STEP="$((REQ_STEP+1))";
        printSNMP;
fi;
