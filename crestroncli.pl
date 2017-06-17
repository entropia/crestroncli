#!/usr/bin/env perl

use v5.12;
use warnings;

use IO::Socket::INET;

if(@ARGV < 1) {
	say STDERR "usage: $0 [on|off|source]";
	exit 1;
}

my $sock = IO::Socket::INET->new(
	#TODO: enter the IP of your projector here!
	PeerAddr => '10.214.225.9',
	PeerPort => 41794,
);

binmode $sock, ":bytes";

sub dsend {
	my ($handle, @data) = @_;

	my $send = pack("C*", @data);

	print $handle $send;
}


if($ARGV[0] eq 'on') {
	dsend($sock, 0x05, 0x00, 0x06, 0x00, 0x00, 0x03, 0x00, 0x04, 0x00);
} elsif($ARGV[0] eq 'off') {
	dsend($sock, 0x05, 0x00, 0x06, 0x00, 0x00, 0x03, 0x00, 0x05, 0x00);
} elsif($ARGV[0] eq 'source') {
	dsend($sock, 0x05, 0x00, 0x06, 0x00, 0x00, 0x03, 0x00, 0x6f, 0x17);
} else {
	say STDERR "Unknown command $ARGV[0]";
	exit 1;
}
