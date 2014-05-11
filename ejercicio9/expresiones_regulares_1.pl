#!/usr/bin/perl -w
use strict;
use MIME::Lite::TT;

my $datos;
my $pagina;
while (<STDIN>){
$_=~m/^(.*?)\s-\s-\s\[(.*?):(.*?)\]\s".*?\s(.*?)\sHTTP.*?".*?"\s"(.*?)\s(.*?)$/;
	if (($1 eq "www.lcc.uma.es" )){
		$datos="HOST:  ".$1."  FECHA:  ".$2."  HORA:  ".$3."  PAGINA  ".$4."  NAVEGADOR:  ".$5;
		$pagina = $4;
		&enviar($datos) if ($pagina=~/.*?.\.pdf$/);
	}
}
sub enviar{

my $template = <<TEMPLATE;

 @_
 
TEMPLATE
 # my %params = (name => 'horiuchi');
 my %options = (EVAL_PERL=>1);

 my $msg = MIME::Lite::TT->new(
             From => 'me@myhost.com',
             To => 'manolo@iesvirgendelcarmen.com',
             Subject => 'hi',
             Template => \$template,
#             TmplParams => \%params,
             TmplOptions => \%options,
           );

 $msg->send();
}

