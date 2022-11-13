#!/bin/bash
# 
# see: http://www.postfix.org/FILTER_README.html
# Simple shell-based filter. It is meant to be invoked as follows:
#       /path/to/script -f sender recipients...

# Localize these. The -G option does nothing before Postfix 2.3.
SENDMAIL="/usr/sbin/sendmail -G -i" # NEVER NEVER NEVER use "-t" here.

# Exit codes from <sysexits.h>
EX_TEMPFAIL=75
EX_UNAVAILABLE=69

# Clean up when done or when aborting.
trap "" 0 1 2 3 15

# Start processing.
if [ "$1" == "" ]; then
	echo "No mail sender is given."; exit $EX_UNAVAILABLE;
fi;
if [ "$2" == "" ]; then
	echo "No mail user is given."; exit $EX_UNAVAILABLE;
fi;

#cat | $SENDMAIL -f "$1" "$2@m4n.nl"
# we use perl to insert into 10025 so , no second amivs scanning is done

cat | perl -e '
use Net::SMTP;
$smtp = Net::SMTP->new($ARGV[0],
Hello => $ARGV[1],
Timeout => 30
);
die "Could not connect to server" unless $smtp;
$smtp->mail( $ARGV[2] );
$smtp->to( $ARGV[3] );
$smtp->data();
while (defined($line = <STDIN>)) {
$smtp->datasend("$line");
}
$smtp->dataend();
$smtp->quit();
' "localhost:10025" "malia" "$1" "$2@m4n.nl"

# normal exit
exit $?
