#!/usr/bin/perl -w
use strict;
use BD1;
&BD1::crear_tabla;
my @datos;
while (<STDIN>){
$_=~m/^(.*?)\s-\s-\s\[(.*?)\/(.*?)\/(.*?):(.*?\s.*?)\]\s".*?\s(.*?)\sHTTP.*?".*?"\s"(.*?)\s(.*?)$/;
&BD1::insertar_datos($1,($4.(&convertir($3)).$2),$5,$6,$7);
}
sub convertir(){
if ($_ eq "Jan"){
 return '01';
}
if ($_ eq "Feb"){
 return '02';
}
if ($_ eq "Mar"){
 return '03';
}
if ($_ eq  "Apr"){
 return '04';
}
if ($_ eq "May"){
 return '05';
}
if ($_ eq "Jun"){
 return '06';
}
if ($_ eq "Jul"){
 return '07';
}
if ($_ eq "Aug"){
 return '08';
}
if ($_ eq "Sep"){
 return '09';
}
if ($_ eq "Oct"){
 return '10';
}
if ($_ eq "Nov"){
 return '11';
}
else{
 return '12';
}
}
