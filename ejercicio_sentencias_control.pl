#!/usr/bin/perl -w

use strict;

#almacen dni vector
my @ dni = (2, 5, 0, 0, 4, 1, 5, 8);

#almacen dni hash
my % dni = (2, 5, 0, 0, 4, 1, 5, 8,);

my $suma = 0;
#usando el bucle for
for (my $i = 0; $i < @dni; $i++)
  {
    $suma += $dni[$i];
  }

print "La suma de los digitos del dni es: ", $suma, "\n";

##BUCLE FOR##
print "Utilizando el bucle FOR\n";
#calculo del factorial de suma:
my $factorial = 1;
for (my $i = 1; $i <= $suma; $i++)
  {
    $factorial *= $i;
  }

print "El factorial de $suma es: ", $factorial, "\n";

#calculo del factorial de suma saltando los múltiplos de 2 y 3:
$factorial = 1;
for (my $i = 1; $i <= $suma; $i++)
  {
    $factorial *= $i unless ($i % 2 == 0 || $i % 3 == 0);
  }

print "El factorial de $suma eliminando múltiplos de 2 y 3 es: ", $factorial,
  "\n\n";



#####################################################################
##BUCLE WHILE##
print "Utilizando el bucle WHILE\n";
#calculo del factorial de suma:
$factorial = 1;
my $i = 1;
while ($i <= $suma)
  {
    $factorial *= $i;
    $i++;
  }

print "El factorial de $suma es: ", $factorial, "\n";

#calculo del factorial de suma saltando los múltiplos de 2 y 3:
$factorial = 1;
$i = 0;
BUCLE_WHILE:while ($i < $suma)
  {
    $i++;
    if ($i % 2 == 0 || $i % 3 == 0)
      {
	next BUCLE_WHILE;
      };
    $factorial *= $i;
  }

print "El factorial de $suma eliminando múltiplos de 2 y 3 es: ", $factorial,
  "\n\n";

#####################################################################
##BUCLE UNTIL##
print "Utilizando el bucle UNTIL\n";
#calculo del factorial de suma:
$factorial = 1;
$i = 1;
until ($i > $suma)
{
  $factorial *= $i;
  $i++;
}

print "El factorial de $suma es: ", $factorial, "\n";

#calculo del factorial de suma saltando los múltiplos de 2 y 3:
$factorial = 1;
$i = 1;
until ($i > $suma)
{
  $factorial *= $i unless ($i % 2 == 0 || $i % 3 == 0);
  $i++;
}

print "El factorial de $suma eliminando múltiplos de 2 y 3 es: ", $factorial,
  "\n\n";

#####################################################################
##BUCLE DO WHILE
print "Utilizando el bucle DO WHILE\n";
#calculo del factorial de suma:
$factorial = 1;
$i = 0;
do
  {
    $i++;
    $factorial *= $i;
  }
while ($i < $suma);
print "El factorial de $suma es: ", $factorial, "\n";

#calculo del factorial de suma saltando los múltiplos de 2 y 3:
$factorial = 1;
$i = 0;
do
  {
    $i++;
    $factorial *= $i unless ($i % 2 == 0 || $i % 3 == 0);
  }
while ($i < $suma);
print "El factorial de $suma eliminando múltiplos de 2 y 3 es: ", $factorial,
  "\n\n";

#####################################################################
##BUCLE DO UNTIL##
print "Utilizando el bucle DO UNTIL\n";
#calculo del factorial de suma:
$factorial = 1;
$i = 1;
do
  {
    $factorial *= $i;
    $i++;
  }
until ($i > $suma);
print "El factorial de $suma es: ", $factorial, "\n";

#calculo del factorial de suma saltando los múltiplos de 2 y 3:
$factorial = 1;
$i = 1;
do
  {
    $factorial *= $i unless ($i % 2 == 0 || $i % 3 == 0);
    $i++;
  }
until ($i > $suma);
print "El factorial de $suma eliminando múltiplos de 2 y 3 es: ", $factorial,
  "\n";
