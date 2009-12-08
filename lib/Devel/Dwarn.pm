package Devel::Dwarn;

use Data::Dumper::Concise::Sugar ();

sub import { goto &Data::Dumper::Concise::Sugar::import }

1;
