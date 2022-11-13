#!/bin/bash
#
# SNMP pass extension script
#
# .0 = GET processes count
# .1 = GET theads count
# .2 = GET RSS (resident set size, the non-swapped physical memory that a task has used in KB)
# .3 = GET VSZ (virtual memory size of the process in KB)
#
# Example;
#   $ snmp-procesinfo.sh apache2 .1.2.3.999 -n .1.2.3.999.1
#

REQ_GREP=$2;
REQ_BASE=$1;
REQ_TYPE=$3;
REQ_OID=$4;
REQ_STEP=`echo $REQ_OID|awk -F. '{print $NF}'`;

# the last awk is for removed a non greped bash process from listing.
GET_PROCESES="ps -ef | grep $REQ_GREP | grep -v grep | grep -v $$ | wc -l";
GET_THREADS="let OUT=\`ps -efL | grep $REQ_GREP | grep -v grep | grep -v $$ | wc -l\`-\`ps -ef | grep $REQ_GREP | grep -v grep | grep -v $$ | wc -l\`;echo \$OUT";
GET_VSZ="ps aux | grep $REQ_GREP | grep -v grep | grep -v $$ | awk '{print \$5}' | sort -n | tail -n1";
GET_RSS="ps aux | grep $REQ_GREP | grep -v grep | grep -v $$ | awk '{print \$6}' | sort -n | tail -n1";

function printData() {
        field=$1;
        data=`bash -c "$2"`;
        if [ "" == "$field" ];then
                return;
        fi;
        echo "$REQ_BASE.$field";
        echo "integer";
        if [ "" == "$data" ];then
                data="0";
        fi
        echo "$data";
}

if [[ "-g" == "$REQ_TYPE" ]]; then
        if [[ $REQ_BASE == $REQ_OID ]];then
                exit;
        fi;
        if [[ "$REQ_STEP" == 0 ]]; then
                printData 0 "$GET_PROCESES";
        fi;
        if [[ "$REQ_STEP" == 1 ]]; then
                printData 1 "$GET_THREADS";
        fi;
        if [[ "$REQ_STEP" == 2 ]]; then
                printData 2 "$GET_VSZ";
        fi;
        if [[ "$REQ_STEP" == 3 ]]; then
                printData 3 "$GET_RSS";
        fi;
fi;
if [[ "-n" == "$REQ_TYPE" ]]; then
        if [[ $REQ_BASE == $REQ_OID ]];then
               printData 0 "$GET_PROCESES";
        fi;
        if [[ "$REQ_STEP" == 0 ]]; then
               printData 1 "$GET_THREADS";
        fi;
        if [[ "$REQ_STEP" == 1 ]]; then
               printData 2 "$GET_VSZ";
        fi;
        if [[ "$REQ_STEP" == 2 ]]; then
               printData 3 "$GET_RSS";
        fi;
fi;
