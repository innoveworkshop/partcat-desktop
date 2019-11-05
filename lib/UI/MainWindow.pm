#!/usr/bin/perl

package UI::MainWindow;

use strict;
use warnings;

use Tkx;
use Carp;
use Try::Tiny;

# Constructor.
sub new {
	my ($class, $title) = @_;
	my $self = {
		mw => Tkx::widget->new("."),
	};

	# Bless the reference.
	bless $self, $class;

	# Setup styling.
	try {
		Tkx::package_require("style");
		Tkx::style__use("as", -priority => 70);
	} catch {
		carp "Tk 'style' package wasn't found. Make sure you have 'tklib' installed";
		exit;
	};

	# Set the window title and layout the components.
	$self->{mw}->g_wm_title($title);
	$self->_setup_menus;
	$self->_setup_layout;

	return $self;
}

# Starts the Tk main loop.
sub show {
	my ($self) = @_;
	Tkx::MainLoop();
}

# Sets up all the menus.
sub _setup_menus {
	my ($self) = @_;

	# Remove tearoff.
	Tkx::option_add("*tearOff", 0);

	# Create the menu and assign it to the window.
	my $menu = $self->{mw}->new_menu;
	$self->{mw}->configure(-menu => $menu);

	# File menu.
	my $m_file = $menu->new_menu;
	$menu->add_cascade(-menu => $m_file, -label => "File");
	$m_file->add_command(-label => "Quit", -command => \&Tkx::exit);

	# Edit menu.
	my $m_edit = $menu->new_menu;
	$menu->add_cascade(-menu => $m_edit, -label => "Edit");

	# Server menu.
	my $m_server = $menu->new_menu;
	$menu->add_cascade(-menu => $m_server, -label => "Server");
	$m_server->add_command(-label => "Connect");
	$m_server->add_command(-label => "Disconnect");
	$m_server->add_separator;
	$m_server->add_command(-label => "Set Location");
	$m_server->add_command(-label => "Set Credentials");
	$m_server->add_command(-label => "Save Configuration");
}

# Lays out all of the components.
sub _setup_layout {
	my ($self) = @_;

	# Setup the mother frame.
	#my $f_main = $self->{mw}->new_ttk__frame;
	#$f_main->g_grid(-column => 0, -row => 0, -sticky => "nwes");

	# Setup the root window to fill with the main widget.
	$self->{mw}->g_grid_columnconfigure(0, -weight => 1);
	$self->{mw}->g_grid_rowconfigure(0, -weight => 1);

	# Setup the main tab view and its frames.
	my $n_main = $self->{mw}->new_ttk__notebook;
	$n_main->g_grid(-column => 0, -row => 0, -sticky => "nwes");
	my $f_comp = $n_main->new_ttk__frame(-padding => 5);
	my $f_cat = $n_main->new_ttk__frame(-padding => 5);
	my $f_img = $n_main->new_ttk__frame(-padding => 5);
	$n_main->add($f_comp, -text => "Components");
	$n_main->add($f_cat, -text => "Categories");
	$n_main->add($f_img, -text => "Images");

	# Setup components tab.
	$self->_setup_component_search($f_comp);
}

# Sets up the component search tab layout.
sub _setup_component_search {
	my ($self, $frm) = @_;

	# Search panel.
	my $f_search = $frm->new_ttk__labelframe(-text => "Search");
	my $c_cat = $f_search->new_ttk__combobox(-values => "All Transistors Interesting Something");
	my $e_mpn = $f_search->new_ttk__entry;
	$f_search->g_grid(-column => 0, -row => 0, -sticky => "nwe");
	$c_cat->g_grid(-column => 0, -row => 0, -sticky => "nw");
	$e_mpn->g_grid(-column => 1, -row => 0);
}

1;

__END__

=head1 NAME

UI::MainWindow - Main window of the GUI application.

=head1 SYNOPSIS

  # Write some sample code.

=head1 METHODS

=over 4

=item I<$mw> = C<UI::MainWindow>->C<new>(I<$title>)

Initializes the main window object with a I<$title>.

=item I<$mw>->C<show>

Starts the Tk main loop.

=back

=head1 AUTHOR

Nathan Campos <nathan@innoveworkshop.com>

=head1 COPYRIGHT

Copyright (c) 2019- Innove Workshop Company.

=cut
