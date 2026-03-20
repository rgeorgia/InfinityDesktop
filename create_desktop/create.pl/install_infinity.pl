#!/usr/pkg/bin/perl

sub has_root_permission {
    my $username = getpwuid($<);

    my $groups_output = qx(id | grep -E "wheel|root");
    chomp($groups_output);
    my @groups = split(/\s+/, $groups_output);
    my $search_for = "wheel";
    my $has_wheel = grep(/$search_for/, @groups) ;

    $has_wheel;
}


if (! has_root_permission) {
    die "Need sudo/doas permissions\n";
}



print "Installing\n";
