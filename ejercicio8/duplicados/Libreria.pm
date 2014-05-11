package Libreria;
use DBI;
use strict;


sub conectar{
	my $driver   = "SQLite";
	my $database = "ficheros.db";
	my $dsn = "dbi:$driver:dbname=$database";
	my $userid = "";
	my $password = "";

	my $dbh_ = DBI->connect($dsn, $userid, $password, {
		RaiseError => 1,AutoCommit => 0 }) or die $DBI::errstr;
	return $dbh_;
}

sub crear_tabla{
my $dbh= &conectar();
eval{
	my $stmt = qq(CREATE TABLE IF NOT EXISTS datos
		   (ID 	INTEGER PRIMARY KEY AUTOINCREMENT,
			PATH_INICIAL	TEXT,
			FILE_INICIAL	TEXT,
			PATH_DUPLICADO	TEXT,
			FILE_DUPLICADO  TEXT);
	);

	my $rv = $dbh->do($stmt);
	$dbh->commit();
	print  "Conexión con la BD exitosa!\n";
};

	if($@){
		print "Error en la conexión de la BD: $@\n";
		$dbh->rollback();
	}
	else{
		$dbh->disconnect;
	}
}

sub insertar_datos{
	my $dbh=&conectar();
	eval{
		my ($path_inicial, $file_inicial, $path_duplicado, $file_duplicado) = @_;
		my $sth=$dbh->prepare("INSERT INTO datos (PATH_INICIAL, FILE_INICIAL, PATH_DUPLICADO, FILE_DUPLICADO) values (?,?,?,?)"); 
		$sth->execute( $path_inicial, $file_inicial,$path_duplicado, $file_duplicado) or die $DBI::errstr;
		$sth->finish();
		$dbh->commit();
	};
	if($@){
		print "Error en la conexión de la BD: $@\n";
		$dbh->rollback();
	}
	else{
		$dbh->disconnect;
	}
}

sub consultar_datos{
	my $dbh=&conectar();
	my $consulta;
	my @filas;
	eval{
		my $file = $_[0];
		my $sql="select * from datos where file_duplicado= '$file';";
		$consulta= $dbh->prepare($sql);
		$consulta->execute();
		@filas=$consulta->fetchrow_array;
		my ($id, $path_original,$fichero_original,$path_copiado,$fichero_copiado)=@filas;
		my $dimension=@filas;
		if (0!=$dimension){
			print "Fichero duplicado: ",$file,"\n";
			print "Copiado desde el path: ",$path_original,"\n";
			print "Copiado al path: ",$path_copiado,"\n";
		}
		else{
			print "El fichero ",$file," no está duplicado\n"; 
		}	
		$consulta->finish;
		$dbh->commit();
	};
	if($@){
		print "Error en la conexión de la BD: $@\n";
		$dbh->rollback();
	}
	else{
		$dbh->disconnect;
	}
}

#llenamos el directorio tmp/jpeg con archivos de tipo jpeg
#también se comprimen
sub crear_tmp_jpeg{
	my @resumen;
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


#llenamos el directorio tmp/png con archivos de tipo png
#también se comprimen
sub crear_tmp_png{
	my @resumen;
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


my @res;
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
	    push @res,$salida;
	}
    } 
}

sub comprobar_doc{
    my $flag=0;
    foreach my $valor(@res){
	$flag= 1 if ($_[0] eq $valor);
    }
    return $flag;
}


#llenamos el directorio tmp/gif con archivos de tipo gif
#también se comprimen
sub crear_tmp_gif{
	my @resumen;
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
