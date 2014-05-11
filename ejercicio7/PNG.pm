package PNG;
use strict;
my @resumen;
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
