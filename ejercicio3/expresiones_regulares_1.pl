#!/usr/bin/perl -w
use strict;
my @datos;
while (<STDIN>){
$_=~m/^(.*?)\s-\s-\s\[(.*?):(.*?)\s.*?\]\s".*?\s(.*?)\sHTTP.*?".*?"\s"(.*?)\s(.*?)$/;
push @datos,$1;
push @datos,$2;
push @datos,$3;
push @datos,$4;
push @datos,$5;
}
&imprimir(@datos);
sub imprimir(){
my $dimension=@_;
for (my $i=0;$i<$dimension;$i++){
print "MAQUINA: ",$_[$i],"\t" if ($i%5==0);
print "FECHA: ",$_[$i],"\t" if ($i%5==1);
print "HORA: ",$_[$i],"\t" if ($i%5==1);
print "PÁGINA: ",$_[$i],"\t" if ($i%5==1);
print "NAVEGADOR: ",$_[$i],"\n\n" if ($i%5==1);
}
}
