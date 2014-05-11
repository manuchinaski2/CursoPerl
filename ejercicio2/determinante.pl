#!/usr/bin/perl -w
use strict;

sub orden(@);
#sub crear_determinante((@,@));

#cálculo del orden del determinante
my @lista=(1,2,3,4);
#my @lista=(1,2,3,4,5,6,7,8,9);
#my @lista=(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16);

sub orden(@){
my $i;
my $longitud=@_;
for ($i=1;$i*$i<$longitud;$i++){
}
return $i;
}


print &crear_determinante(@lista,@lista),"\n";
sub crear_determinante(){
my $orden=2;
my $det=0;
if ($orden == 1){
	$det= $_[0];
}elsif($orden ==2){
	$det= $_[0]*$_[2]-$_[1]*$_[3];
}
else{
for (my $i=0; $i<$orden-1;$i++){
 for (my  
return $det;
}


