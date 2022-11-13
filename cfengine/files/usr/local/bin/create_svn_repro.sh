#!/bin/bash

REPRO_PATH="file:///svn";
REPRO_WEBDAV="https://svn.mbuyu.nl/svn";
REPRO_COMMIT="project_creation"; # NO SPACES
REPRO_TYPE=$1;
REPRO_NAME=$2;

print_usage() {
        echo "Use: '$0 sandbox test-project'";
        exit 1;
}

if [ "$REPRO_TYPE" == "" ]
then
        print_usage;
fi;

if [ "$REPRO_NAME" == "" ]
then
        print_usage;
fi;

REPRO_ROOT="$REPRO_PATH/$REPRO_TYPE/$REPRO_NAME";

echo "Willing to create repro: '$REPRO_ROOT'";
if [ ! "$EXECUTE" == "true" ]
then
        echo -n "Do you want to continue ? (y/n) ";
        read  RESULT;
        if [ "$RESULT" != "y" ]
        then
                echo "Nothing created.(canceled)";
                exit 0;
        fi;
fi;

EXE_CMD="svn mkdir -q -m $REPRO_COMMIT $REPRO_ROOT";
echo -e "Creating root: $EXE_CMD";
$EXE_CMD && echo "...done" || exit $?;

EXE_CMD="svn mkdir -q -m $REPRO_COMMIT $REPRO_ROOT/tags";
echo -e "Creating tags: $EXE_CMD";
$EXE_CMD && echo "...done" || exit $?;

EXE_CMD="svn mkdir -q -m $REPRO_COMMIT $REPRO_ROOT/branches";
echo -e "Creating branches: $EXE_CMD";
$EXE_CMD && echo "...done" || exit $?;

EXE_CMD="svn mkdir -q -m $REPRO_COMMIT $REPRO_ROOT/trunk";
echo -e "Creating trunk: $EXE_CMD";
$EXE_CMD && echo "...done" || exit $?;

echo "";
echo "To checkout(subversive) use: '$REPRO_WEBDAV/$REPRO_TYPE/$REPRO_NAME'";
echo "To checkout(svn+ssh) use: 'svn+ssh://$REPRO_BASE/$REPRO_TYPE/$REPRO_NAME'";
echo "all done";
exit 0;
