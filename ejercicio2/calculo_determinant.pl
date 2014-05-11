#!/usr/bin/perl -w

use strict;
sub determinant(@);
sub dimension(@);
my @determinante = (0,1,2,3,4,5,6,7,8);
print @determinante,"\n";
sub dimension(@){
my $tamano = @_;
my $i=0;
while ($i**$i < $tamano) {
$i++;
}
return $i;
}

sub determinant(@) {
my $dim = &dimension(@_);
if ($dim < 2) {
return 0;
}
elsif ($dim ==2) {
return $_[0]*$_[3]-$_[1]*$_[2];
}
else {
my @lista;
for (my $i =$dim+1;$i<$dim*$dim;$i++){
print "valor de i: ",$i,"\n";
push @lista,$_[$i] unless ($i % $dim == 0);
}
print @lista,"\n";
}
}
print "Resultado: ",&determinant(@determinante),"\n";



