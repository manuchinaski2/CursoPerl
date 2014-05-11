package Punto;

use strict;

sub new {
	my $clase=shift;
	my $yomismo={};
	$yomismo->{coordX} = undef;
	$yomismo->{coordY} = undef;
	bless $yomismo,$clase;
	return $yomismo;
}

sub coordenadaX{
	my $yomismo =shift;
	if (@_) {$yomismo->{coordX} = shift};
	return $yomismo->{coordX};
}
sub coordenadaY{
	my $yomismo =shift;
	if (@_) {$yomismo->{coordY} = shift};
	return $yomismo->{coordY};
}


1;


