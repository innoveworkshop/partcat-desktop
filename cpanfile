requires 'Carp', '>= 1.50';
requires 'Config::Tiny', '>= 2.24';
requires 'File::MimeInfo', '>= 0.29';
requires 'JSON::MaybeXS', '>= 1.004000';
requires 'Cpanel::JSON::XS', '>= 4.15';
requires 'Try::Tiny', '>= 0.30';
requires 'Getopt::Long', '>= 2.51';
requires 'Pod::Usage', '>= 1.70';
requires 'File::Spec', '>= 3.75';
requires 'Tk', '>= 804.035';
requires 'Tkx', '>= 1.09';

on 'test' => sub {
	requires 'Test::Spec', '>= 0.54';
};

on 'develop' => sub {
	recommends 'Perl::Critic', '>= 1.134';
};
