#!/usr/bin/perl -w

use strict;
use paquete;


#Comprobación de los datos

print
  "\n=====================================================================\n\n";
print "Valor del vector dni: ", &paquete::imprimir_vector (@paquete::dni), "\n";
print "Valor de la suma de componentes vector de forma iterativa: ",
  &paquete::suma_iterativa_vector (@paquete::dni), "\n";
print "Valor de la suma de componentes vector de forma recursiva: ",
  &paquete::suma_recursiva_vector (@paquete::dni), "\n";
print
  "=====================================================================\n\n";
#sumamos dos vectores si son de la misma dimensión
my @ vector_suma = &paquete::suma_vectores (@paquete::dni, @paquete::dni) if ($paquete::dni == $paquete::dni);
print "Suma del vector dni con vector dni : ",
  &paquete::imprimir_vector (@vector_suma), "\n";

my $multiplicando = 10;
print "Valor de multiplicar el vector dni por ", $multiplicando, " es: ",
  &paquete::imprimir_vector (&paquete::multiplicacion_vector_numero ($multiplicando, @paquete::dni)),
  "\n";
print
  "=====================================================================\n\n";

#multiplicamos vector y matriz si son de la misma dimensión
print "Multiplicacion del vector: ", &paquete::imprimir_vector (@paquete::dni),
  " por la  matriz:\n";
&paquete::imprimir_matriz (@paquete::matriz);
print "Resultado:\n";
my $matriz = &paquete::dimension_vector (@paquete::matriz);
&paquete::imprimir_matriz (&paquete::multiplicacion_vector_matriz ($matriz, @paquete::dni, @paquete::matriz))
  if ($matriz == $paquete::dni);
print
  "=====================================================================\n\n";

#sumamos dos matrices si son de la misma dimensión
print "Suma de dos matrices:\nMatriz 1:\n";
&paquete::imprimir_matriz (@paquete::matriz);
print "Matriz 2:\n";
&paquete::imprimir_matriz (@paquete::matriz_aux);
print "Resultado:\n";
&paquete::imprimir_matriz (&paquete::suma_matrices (@paquete::matriz, @paquete::matriz_aux))
  if (&paquete::dimension_vector (@paquete::matriz) == &paquete::dimension_vector (@paquete::matriz_aux));
print
  "=====================================================================\n\n";

