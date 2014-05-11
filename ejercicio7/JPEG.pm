package JPEG;
use strict;
my @resumen;
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


1;
