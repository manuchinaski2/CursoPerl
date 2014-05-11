#!/usr/bin/perl -w

#La fecha se solita con el siguiente formato:
# dia_inicial/mes_inicial/año_inicial-dia_fina/mes_final/año_final
#Ejemplo:

#    12/12/2001-1/10/2013

use strict;
use Libreria;
my $fichero= $ARGV[0];
$fichero=~/(.*)\/(.*)$/;
my ($path, $file) = ($1,$2);


my $consulta=&Libreria::consultar_datos($2);
