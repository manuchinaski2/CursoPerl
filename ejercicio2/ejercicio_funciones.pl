#!/usr/bin/perl -w

use strict;

my @dni=(2,5,9,1,1,5,8);

#definicion de funciones
sub suma_dos_sumandos($$);
sub suma_lista(@);
sub comprobar($);



#implementación de las funciones

sub suma_dos_sumandos($$){
return ($_[0]+$_[1]);
}

sub suma_lista(@){
my $suma=0;
for my $valor(@_){
$suma+=$valor unless (&comprobar($valor)!=0);
}
return $suma;
}

sub comprobar($){
(my $recibido)= @_;
my $devolver=0;
for my $valores(@dni){
$devolver=1 if ($valores ==$recibido);
}
return $devolver;
}

##llamadas a las funciones

my $sumando1=4;
my $sumando2=5;
my @lista=(1,5,8,9,7,8,6);
print "La suma de $sumando1 y $sumando2 es: ",&suma_dos_sumandos($sumando1,$sumando2),"\n";
print "La suma de los valores de @lista es con digitos no contenidos en @dni es : ",&suma_lista(@lista),"\n";
