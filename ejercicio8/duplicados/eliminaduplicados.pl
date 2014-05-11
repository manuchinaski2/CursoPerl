#!/usr/bin/perl -w


use strict;
use Libreria;

#Crear la BD
&Libreria::crear_tabla;

#Creación del directorio temporal y subdirectorios
qx(rm -rf tmp) unless (-e " tmp");
qx(mkdir -p tmp/png);
qx(mkdir -p tmp/jpeg);
qx(mkdir -p tmp/gif);
qx(mkdir -p tmp/copiados/);

my @ficheros =qx(find fuente1 -type f -print); #lista de ficheros
#del directorio fuente1

#llenamos los ficheros temporales
# tmp/jpeg tmp/gif tmp/png en las siguientes llamadas
&Libreria::crear_tmp_gif;
&Libreria::crear_tmp_jpeg;
&Libreria::crear_tmp_png;

#Busco el tipo de fichero con el comando fil
my @tipo_fichero;
foreach my $fichero(@ficheros){
    my $salida =qx(file $fichero); #lista tipo de ficheros
    $salida=~/(.*?)\s(.*?)\s/; #puenden ser Composite, GIF, JPEG o PNG
    if ($2 eq "Composite"){
	$salida= qx(catdoc $fichero); #salida catdoc de cada fichero doc de fuente1
    my $comprobacion= &Libreria::comprobar_doc($salida,"\n"); #enviamos cada salida a la subrutina para comprobar si coincide con los fichero que ya hay
	if ($comprobacion == 0){ #está en fuente2
#	    $fichero=~/.*\/(.*?)$/;
            $fichero=~/(.*)\/(.*)$/;
            chomp($fichero);
	    qx(cp "./$fichero" "./fuente2/documentos");
	    print "Copiado fichero ", $2,"\n";
	    &BD2::insertar_datos($1,$2,"fuente2/documentos",$2);
	    
	}
    }
    if ($2 eq "GIF"){
	chop($fichero);
	$fichero=~/.*\/(.*?)$/;
	qx(gifsicle -O2 -b $fichero -o tmp/copiados/$1); #comprimo ficheros para posterior comparación
    }
    if ($2 eq "JPEG"){
	chop($fichero);
	$fichero=~/.*\/(.*?)$/;
	qx(jpegoptim -p $fichero -d tmp/copiados); #comprimo ficheros para posterior comparación
    }
    if ($2 eq "PNG"){
	chop($fichero);
	$fichero=~/.*\/(.*?)$/;
	qx(optipng -o7  $fichero -out tmp/copiados/$1); #comprimo ficheros para posterior comparación
    }
}

#Analizamos los temporales:

my @ficheros_temporales =qx(find tmp/copiados/ -type f -print); #lista de ficheros temporales ya comprimidos
foreach my $ficheros_temporales(@ficheros_temporales){
    my $salida =qx(file $ficheros_temporales); #lista tipo de ficheros
    $salida=~/(.*?)\s(.*?)\s/; #puenden ser GIF, JPEG o PNG
    if ($2 eq "GIF"){
	chop($ficheros_temporales);
#	$ficheros_temporales=~/.*\/(.*?)$/;
        $ficheros_temporales=~/(.*)\/(.*)$/;
	my $copia1=&Libreria::existe_gif($ficheros_temporales); #devuelve 0 si el fichero no existe en tmp/gif
	if ($copia1==0){
	    system("cp ./$ficheros_temporales ./fuente2/imagenes/");
	    print "Copiado fichero ", $2,"\n";
	    &Libreria::insertar_datos("fuente1/imagenes",$2,"fuente2/imagenes",$2);
	}
    }
    if ($2 eq "JPEG"){
	chop($ficheros_temporales);
	#$ficheros_temporales=~/.*\/(.*?)$/;
        $ficheros_temporales=~/(.*)\/(.*)$/;
	my $copia2=&Libreria::existe_jpeg($ficheros_temporales); #devuelve 0 si el fichero no existe en tmp/jpeg
	if ($copia2==0){
	    system("cp ./$ficheros_temporales ./fuente2/imagenes/");
	    print "Copiado fichero ", $2,"\n";
	    &Libreria::insertar_datos("fuente1/imagenes",$2,"fuente2/imagenes",$2);
	}
    }
    if ($2 eq "PNG"){
	chop($ficheros_temporales);
	$ficheros_temporales=~/.*\/(.*?)$/;
	my $copia3=&Libreria::existe_png($ficheros_temporales); #devuelve 0 si el fichero no existe en tmp/png
	if ($copia3==0){
	    system("cp ./$ficheros_temporales ./fuente2/imagenes/");
	    print "Copiado fichero ", $1,"\n";
	    &Libreria::insertar_datos("fuente1/imagenes",$1,"fuente2/imagenes",$1);
	}
    }
}	
