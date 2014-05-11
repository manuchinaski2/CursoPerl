package Correo;
use strict;
use MIME::Lite::TT;

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
1;
