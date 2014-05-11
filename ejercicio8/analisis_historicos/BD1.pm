package BD1;
use DBI;
use strict;


sub conectar{
my $driver   = "SQLite";
my $database = "apache.db";
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
my $stmt = qq(CREATE TABLE IF NOT EXISTS logs
       (ID 	INTEGER PRIMARY KEY AUTOINCREMENT,
        HOST	TEXT,
	FECHA	TEXT,
	HORA	TEXT,
        PAGINA	TEXT,
       NAVEGADOR	TEXT););
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
my ($host, $fecha, $hora, $pagina,$navegador) = @_;
my $sth=$dbh->prepare("INSERT INTO logs (HOST, FECHA, HORA, PAGINA ,NAVEGADOR ) values (?,?,?,?,?)"); 
$sth->execute( $host, $fecha,$hora, $pagina, $navegador) or die $DBI::errstr;
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
my ($fecha_inicial,$fecha_final) = split(/:/,$_[0]);
my $sql="select host, fecha, hora, pagina, navegador from logs where FECHA between $fecha_inicial and $fecha_final;";
$consulta= $dbh->prepare($sql);
$consulta->execute();
@filas=$consulta->fetchrow_array;
foreach (@filas)
{
my ($host,$fecha,$hora,$pagina,$navegador)=@filas;
print "HOST: ",$host,"\n";
print "FECHA: ",$fecha,"\n";
print "HORA: ",$hora,"\n";
print "PAGINA: ",$pagina,"\n";
print "NAVEGADOR: ",$navegador,"\n\n";
};

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

1;
