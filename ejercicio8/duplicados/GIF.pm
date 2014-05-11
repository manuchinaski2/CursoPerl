package GIF;
use strict;
my @resumen;
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


1;
