#!/usr/bin/perl -w

use strict;

#===================================
#definición de las funciones
sub imprimir_vector (@);
sub imprimir_matriz (@);
sub dimension_vector (@);
sub suma_vectores (@);
sub suma_iterariva_vector (@);
sub suma_recursiva_vector (@);
sub multiplicacion_vector_numero ($ @);
sub multiplicacion_vector_matriz ($ @);
sub suma_matrices (@);

#===================================

#datos iniciales
my @ dni = (2, 5, 9, 9, 1, 2, 3, 4);
#vector dni
my $dni = @dni;
#dimension del vector
my @ matriz = (
#matriz para operar
		(1, 1, 1, 1, 1, 1, 1, 1),
		(2, 2, 2, 2, 2, 2, 2, 2),
		(3, 3, 3, 3, 3, 3, 3, 3),
		(4, 4, 4, 4, 4, 4, 4, 4),
		(5, 5, 5, 5, 5, 5, 5, 5),
		(6, 6, 6, 6, 6, 6, 6, 6),
		(7, 7, 7, 7, 7, 7, 7, 7),
		(8, 8, 8, 8, 8, 8, 8, 8));
my @ matriz_aux = (
#matriz auxiliar para operar
		    (10, 10, 10, 10, 10, 10, 10, 10),
		    (20, 20, 20, 20, 20, 20, 20, 20),
		    (30, 30, 30, 30, 30, 30, 30, 30),
		    (40, 40, 40, 40, 40, 40, 40, 40),
		    (50, 50, 50, 50, 50, 50, 50, 50),
		    (60, 60, 60, 60, 60, 60, 60, 60),
		    (70, 70, 70, 70, 70, 70, 70, 70),
		    (80, 80, 80, 80, 80, 80, 80, 80));

#===================================

#implementación de las funciones:

sub
imprimir_matriz (@)
{
  my $dimension = &dimension_vector (@_);
  my $contador = 1;
  foreach my $valor (@_)
  {
    print $valor;
    print "-" if (($contador % $dimension) != 0);
    print "\n" if ((($contador % $dimension) == 0) && ($contador != 0));
    $contador++;
  }
}

sub
dimension_vector (@)
{
  my $i;
  my $longitud = @_;
  for ($i = 1; $i * $i < $longitud; $i++)
    {
    }
  return $i;
}

sub
imprimir_vector (@)
{
  my @ lista_formateada;
  foreach my $valor (@_)
  {
    push @ lista_formateada, $valor;
    push @ lista_formateada, "-";
  }
  pop (@lista_formateada);
  return @lista_formateada;
}

sub
multiplicacion_vector_matriz ($ @)
{
  (my $dimension, my @ vector_inicial) = @_;
  my @ vector;
  my @ matriz;
  for (my $i = 0; $i < $dimension; $i++)
    {
      my $valor = shift (@vector_inicial);
      push @ vector, $valor;
    }
  my $contador = 0;
  foreach my $valor (@vector_inicial)
  {
    push @ matriz, $valor * $vector[$contador % $dimension];
    $contador++;
  }
  return @matriz;
}


#suma iterativa componentes vector
sub
suma_iterativa_vector (@)
{
  my $suma = 0;
  foreach my $valor (@_)
  {
    $suma += $valor;
  }
  return $suma;
}

#suma recursiva componentes vector
sub
suma_recursiva_vector (@)
{
  my $tamano = @_;
  if ($tamano == 1)
    {
      return $_[0];
    }
  else
    {
      return pop (@_) + &suma_recursiva_vector (@_);
    }
}

sub
suma_vectores (@)
{
  my @ nuevo_vector;
  my $dimension = @_ / 2;
  for (my $i = 0; $i < $dimension; $i++)
    {
      push @ nuevo_vector, $_[$i] + $_[$i + $dimension];
    }
  return @nuevo_vector;
}

sub
multiplicacion_vector_numero ($ @)
{
  (my $multiplicador, my @ vector) = (@_);
  my $dimension = @vector;
  my @ nuevo_vector;
  for (my $i = 0; $i < $dimension; $i++)
    {
      push @ nuevo_vector, $vector[$i] * $multiplicador;
    }
  return @nuevo_vector;
}

sub
suma_matrices (@)
{
  my $dimension = @_ / 2;
  my @ matriz1;
  my @ matriz2;
  my @ matriz_final;
  for (my $i = 0; $i < $dimension; $i++)
    {
      push @ matriz1, $_[$i];
    }
  for (my $i = $dimension; $i < $dimension * 2; $i++)
    {
      push @ matriz2, $_[$i];
    }
  for (my $i = 0; $i < $dimension; $i++)
    {
      push @ matriz_final, $matriz1[$i] + $matriz2[$i];
    }
  return @matriz_final;
}

#===================================

#Comprobación de los datos

print
  "\n=====================================================================\n\n";
print "Valor del vector dni: ", &imprimir_vector (@dni), "\n";
print "Valor de la suma de componentes vector de forma iterativa: ",
  &suma_iterativa_vector (@dni), "\n";
print "Valor de la suma de componentes vector de forma recursiva: ",
  &suma_recursiva_vector (@dni), "\n";
print
  "=====================================================================\n\n";
#sumamos dos vectores si son de la misma dimensión
my @ vector_suma = &suma_vectores (@dni, @dni) if ($dni == $dni);
print "Suma del vector dni con vector dni : ",
  &imprimir_vector (@vector_suma), "\n";

my $multiplicando = 10;
print "Valor de multiplicar el vector dni por ", $multiplicando, " es: ",
  &imprimir_vector (&multiplicacion_vector_numero ($multiplicando, @dni)),
  "\n";
print
  "=====================================================================\n\n";

#multiplicamos vector y matriz si son de la misma dimensión
print "Multiplicacion del vector: ", &imprimir_vector (@dni),
  " por la  matriz:\n";
&imprimir_matriz (@matriz);
print "Resultado:\n";
my $matriz = &dimension_vector (@matriz);
&imprimir_matriz (&multiplicacion_vector_matriz ($matriz, @dni, @matriz))
  if ($matriz == $dni);
print
  "=====================================================================\n\n";

#sumamos dos matrices si son de la misma dimensión
print "Suma de dos matrices:\nMatriz 1:\n";
&imprimir_matriz (@matriz);
print "Matriz 2:\n";
&imprimir_matriz (@matriz_aux);
print "Resultado:\n";
&imprimir_matriz (&suma_matrices (@matriz, @matriz_aux))
  if (&dimension_vector (@matriz) == &dimension_vector (@matriz_aux));
print
  "=====================================================================\n\n";
