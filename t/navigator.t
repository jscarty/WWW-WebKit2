use strict;
use warnings;
use utf8;

use Test::More;
use lib 'lib';
use FindBin qw($Bin $RealBin);
use lib "$Bin/../../Gtk3-WebKit2/lib";
use URI;

use_ok 'WWW::WebKit2';

my $webkit = WWW::WebKit2->new(xvfb => 1);
eval { $webkit->init; };
if ($@ and $@ =~ /\ACould not start Xvfb/) {
    $webkit = WWW::WebKit2->new();
    $webkit->init;
}
elsif ($@) {
    diag($@);
    fail('init webkit');
}

$webkit->open("$Bin/test/load.html");
ok(1, 'opened');
$webkit->refresh;
$webkit->open("$Bin/test/type.html");
$webkit->go_back;

# submitting leads to a "URL can't be shown" error, but technically it works.
$webkit->open("$Bin/test/type.html");
$webkit->submit('css=form');

done_testing;
