#!/usr/bin/perl -w

sub imprimir($@);
use strict;
my $numero=9;
my @lista=(1,2,3);
my @lista1=(1,2,3);
print pop(@lista),"\n";
print @lista,"\n";
sub imprimir($@){
(my $valor,my @n)= @_;
print $valor,"\n";
print @n,"\n";
}
&imprimir($numero,@lista1);
