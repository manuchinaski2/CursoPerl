package Libreria;
use strict;
# Buscamos las correspondintes salidas de catdoc 
# de los ficheros que existen

my @resumen;
sub crear_tmp_doc{
    my $salida;
    my $tipo;
    my @doc = qx(find fuente2/ -type f -print);
    foreach my $doc(@doc){
        $tipo=qx(file $doc);
        if ($tipo=~/(.*?)\sComposite\s/){
            $salida= qx(catdoc $doc);
	    push @resumen,$salida;
	}
    } 
}

sub comprobar_doc{
    my $flag=0;
    foreach my $valor(@resumen){
	$flag= 1 if ($_[0] eq $valor);
    }
    return $flag;
}


#tratamiento de ficheros JPEG;
#llenamos el directorio tmp/jpeg con archivos de tipo jpeg
#también se comprimen
sub crear_tmp_jpeg{
    my $salida;
    my $tipo;
    my @doc = qx(find fuente2/ -type f -print);
    foreach my $doc(@doc){
        $tipo=qx(file $doc);
        if ($tipo=~/(.*?)\sJPEG\s/){
	   $doc=~/.*\/(.*?)$/;
	   chomp($doc);
           qx(cp $doc tmp/jpeg ); #primero lo copiamos
	   qx(jpegoptim -p $doc -d tmp/jpeg 2>null); #lo comprimimos
	   #Hago la copia pues si no puede comprimirlo no lo manda
	   # a tmp/jpeg por lo que siempre estará vacío este fichero
           # y no podrá comparar
	}
    } 
}

sub existe_jpeg{
	my $flag=0;
        my @jpeg =qx(find tmp/jpeg -type f -print);
	foreach my $jpeg(@jpeg){
            chop($jpeg);
	    system("diff --normal $jpeg $_[0] 1>null");
	    $flag =1 if $? == 0;
	}
	    return $flag;
}


#tratamiento de ficheros#tratamiento de ficheros GIF
#llenamos el directorio tmp/gif con archivos de tipo gif
#también se comprimen
sub crear_tmp_gif{
    my $salida;
    my $tipo;
    my @doc = qx(find fuente2/ -type f -print);
    foreach my $doc(@doc){
        $tipo=qx(file $doc);
        if ($tipo=~/(.*?)\sGIF\s/){
	   $doc=~/.*\/(.*?)$/;
	   chomp($doc);
	   qx(gifsicle -O2 -b $doc -o tmp/gif/$1);
	}
    } 
}

sub existe_gif{
	my $flag=0;
        my @gif =qx(find tmp/gif -type f -print);
	foreach my $gif(@gif){
            chop($gif);
	    system("diff --normal $gif $_[0] 1>null");
	    $flag =1 if $? == 0;
	}
	    return $flag;
}


#tratamiento de ficheros PNG;
#llenamos el directorio tmp/png con archivos de tipo png
#también se comprimen
sub crear_tmp_png{
    my $salida;
    my $tipo;
    my @doc = qx(find fuente2/ -type f -print);
    foreach my $doc(@doc){
        $tipo=qx(file $doc);
        if ($tipo=~/(.*?)\sPNG\s/){
	   $doc=~/.*\/(.*?)$/;
	   chomp($doc);
	   qx(optipng -o7 $doc -out tmp/png/$1);
	}
    } 
}

sub existe_png{
	my $flag=0;
        my @png =qx(find tmp/png -type f -print);
	foreach my $png(@png){
            chop($png);
	    system("diff --normal $png $_[0] 1>null");
	    $flag =1 if $? == 0;
	}
	    return $flag;
}

1;
