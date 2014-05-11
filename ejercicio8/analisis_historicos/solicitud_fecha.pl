#!/usr/bin/perl -w

#La fecha se solita con el siguiente formato:
# dia_inicial/mes_inicial/año_inicial-dia_fina/mes_final/año_final
#Ejemplo:

#    12/12/2001-1/10/2013

use strict;
use BD1;
my $fecha= $ARGV[0];
$fecha =~m/^(\d*)\/(\d*)\/(\d*)-(\d*)\/(\d*)\/(\d*)/ || die ("Error en formato de fecha");

my ($dia1, $mes1, $anno1, $dia2, $mes2, $anno2) = ($1,$2,$3,$4,$5,$6);


$dia1="0".$dia1 if length($dia1)==1;
$dia2="0".$dia2 if length($dia2)==1;

my $date = $dia1.$mes1.$anno1.":".$dia2.$mes2.$anno2;

my $consulta=&BD1::consultar_datos($date);
print $consulta;
