#!/usr/bin/perl

use strict;
use warnings;

use JSON;

use Data::Dumper;

# Write some debug to /tmp
open my $fl, ">>", "/tmp/fastnetmon_notify_script.log" or die "Could not open file for writing";

# Read data from stdin
my $input_attack_details = join '', <STDIN>;

# try to decode this data to json
my $attack_details = eval{ decode_json($input_attack_details); };

# report error
if ($@) {
    print {$fl} "JSON decode failed: $input_attack_details\n";
    die "JSON decode failed\n";
}

print {$fl} Dumper($attack_details);

# Action could be: ban, unban, attack_status for BGP Blackhole mode and partial_block, partial_unblock for BGP Flow Spec mode
my $action = $attack_details->{"action"};

my $scope = $attack_details->{"alert_scope"};

if ($scope eq "" or $scope eq "host") {
    my $ip_address = $attack_details->{"ip"};

    print {$fl} "Callback action $action for host $ip_address\n";
} elsif ($scope eq "hostgroup") {
    my $hostgroup_name = $attack_details->{"hostgroup_name"};

    print {$fl} "Callback action $action for hostgroup $hostgroup_name\n";
} else {
    print {$fl} "Unknown scope $scope\n";
}   

close $fl;

exit 0;
