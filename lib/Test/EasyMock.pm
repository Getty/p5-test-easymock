package Test::EasyMock;
use strict;
use warnings;
use Exporter 'import';
use vars qw( @EXPORT );

@EXPORT = qw( new_mock );

use Data::Dumper;

sub new_mock {
	my @tests;
	my @classes;
	my $mock = {};
	for (@_) {
		if (!ref $_) {
			push @classes, $_;
		} elsif (ref $_ eq 'ARRAY') {
			push @tests, @{$_};
		} elsif (ref $_ eq 'HASH') {
			for my $k (keys %{$_}) {
				$mock->{$k} = $_->{$k};
			}
		}
	}
	push @classes, 'Test::EasyMock::Generated::Class' if !@classes;
	my $class = shift @classes;
	if (defined *{$class.'::'}) {

	} else {
		my $package_code = '
package '.$class.';
use parent qw('.join(' ',@classes).');

our $AUTOLOAD;

use Data::Dumper;

sub test {
	print Dumper "HUHUHU test HUHUHUU";
}

sub AUTOLOAD {
	my $self = shift;

	my $name = $AUTOLOAD;
	$name =~ s/.*://;   # strip fully-qualified portion

	print Dumper $name;
}  

1;';
		print Dumper $package_code;
		{
			eval $package_code;
		}
	}
	$mock->{___test_easymock_tests} = \@tests;
	bless $mock, $class;
	return $mock;
}

1;
