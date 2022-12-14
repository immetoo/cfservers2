#!/usr/bin/perl

use Getopt::Long;
use MIME::Entity;
use Net::SMTP;

my $server = 'localhost';
my $port = 10024;
my $from = 'nagios@m4n.nl';
my $to = 'systeembeheer@m4n.nl';
my $debug = 0;

$result = GetOptions (
        "server|s=s"    =>      \$server,
        "port|p=s"      =>      \$port,
        "from|f=s"      =>      \$from,
        "debug|d"      =>      \$debug,
        "to|t=s"        =>      \$to,
);

if (!$server || !$from) {
        die ("Please specify server, from\n");
}

if (!$to) { $to = $from; }

my $EICAR = <<'EOF';
X5O!P%@AP[4\PZX54(P^)7CC)7}$EICAR-STANDARD-ANTIVIRUS-TEST-FILE!$H+H*
EOF

my $top = MIME::Entity->build(
        Type    =>"multipart/mixed",
        From    => $from,
        To      => $to,
        Subject => "EICAR test",
        Data    => "This is a test",
);

$top->attach(
        Data    => $EICAR,
        Type    => "application/x-msdos-program",
        Encoding        => "base64");

my $smtp = new Net::SMTP(
        $server,
        Port => $port,
        Debug => $debug,
);

if (!$smtp) {
        print "CRITICAL - amavisd-new server unreachable\n";
        exit 2;
}

$smtp->mail($from);
$smtp->to($to);
$smtp->data();
$smtp->datasend($top->stringify);
$smtp->dataend();
my $result = $smtp->message();
$smtp->close();

if ($result =~/2.7.0 Ok, discarded/) {
        print "OK - All fine\n"
} else {
        print "CRITICAL - amavisd-new returned $result";
	exit 1;
}
