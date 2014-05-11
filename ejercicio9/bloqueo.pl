#/usr/bin/perl -w

use strict;
use DBI;

sub conectar{
    my $driver   = "SQLite";
	my $database = "correo.db";
    my $dsn = "dbi:$driver:dbname=$database";
    my $userid = "";
    my $password = "";

    my $dbh_ = DBI->connect($dsn, $userid, $password, {
        RaiseError => 1,AutoCommit => 1 }) or die $DBI::errstr;
	
}
open (HISTORICO, ">> /home/manu/curso_perl/ejercicio9/corroe.log");
print HISTORICO "NUEVO CORREO";
close HISTORICO;


