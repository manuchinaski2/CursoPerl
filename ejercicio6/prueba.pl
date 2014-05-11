#!/usr/bin/perl -w

use strict;
use Punto;

my $mipunto=Punto->new;

$mipunto->coordenadaX(12);
$mipunto->coordenadaY(2);
print $mipunto->coordenadaX,"\n";
print $mipunto->coordenadaY,"\n";
