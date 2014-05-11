package Word;
use strict;
my @resumen;
# Buscamos las correspondintes salidas de catdoc 
# de los ficheros que existen
BEGIN{
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
1;
