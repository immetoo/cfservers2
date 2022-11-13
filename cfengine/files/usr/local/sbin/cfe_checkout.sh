#!/bin/bash

CFE_DIR="/var/lib/cfengine2/";
HGR_DIR="/var/lib/cfengine2/repro/cfservers";

cd $HGR_DIR;
hg pull;
hg update -C;

cp -fr $HGR_DIR/cfengine/inputs/* /etc/cfengine/;
cp -fr $HGR_DIR/cfengine/files/*  $CFE_DIR/files/;
cp -fr $HGR_DIR/docs/* 			  $CFE_DIR/docs/;

echo "Done $0";
