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

sub copy_files {
	my ($src, $dest);

}

sub make_backup {
	my ($src, $dest);
}

sub make_home {

}

sub setup_dot_config {

}

sub setup_dot_fvwm {

}

sub copy_home_dot_files {

}

sub change_to_fish {

}

sub install_services {

}

sub copy_rc_init_files {

}

sub update_rc_conf {

}

sub start_service {
	# pass in a single service to start, that way we have more 
	# control if there is a failure.
	# Easier to test too.
}

sub main {

	if (! has_root_permission) {
	    die "Need sudo/doas permissions\n";
	}
	print "Installing\n";
}


exit main;
