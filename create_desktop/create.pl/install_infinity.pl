#!/usr/pkg/bin/perl
use strict;
use warnings;

my $username = getpwuid($<);

my $groups_output = qx(id | grep -E "wheel|root");
chomp($groups_output);
my @groups = split(/\s+/, $groups_output);

print "Groups for $username: @groups\n";

print "Installing\n";
