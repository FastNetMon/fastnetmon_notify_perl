#!/usr/bin/perl

use strict;
use warnings;

use JSON;

use Data::Dumper;

# Write some debug to /tmp
open my $fl, ">>", "/tmp/fastnetmon_notify_script.log" or die "Could not open file for writing";

# This script executed from FastNetMon this way: ban 11.22.33.44

if (scalar @ARGV != 2) {
    print {$fl} "Please specify all arguments. Got only: @ARGV\n";
    die "Please specify all arguments\n";
}

my ($action, $ip_address) = @ARGV;
# action could be: ban, unban, partial_block

# Read data from stdin
my $input_attack_details = join '', <STDIN>;

# try to decode this data to json
my $attack_details = eval{  decode_json($input_attack_details); };

# report error
if ($@) {
    print {$fl} "JSON decode failed: $input_attack_details\n";
    die "JSON decode failed\n";
}

print {$fl} "Received notification about $ip_address with action $action\n";
print {$fl} Dumper($attack_details);

close $fl;

exit 0;
