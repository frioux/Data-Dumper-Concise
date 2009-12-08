use strict;
use warnings;
use Data::Dumper::Concise::Sugar;

use Data::Dumper::Concise ();

use Test::More qw(no_plan);
use Test::Warn;

my @foo;
warnings_like {
   @foo = Dwarn 'warn', 'friend';
} [qr/"warn"/,qr/friend/], "Dwarn warns";

ok eq_array(\@foo, ['warn']), 'Dwarn passes through correctly';

my $bar;
warning_like {
   $bar = DwarnS 'robot',2,3;
} qr{^"robot"$}, "DwarnS warns";

is $bar, 'robot', 'DwarnS passes through correctly';
