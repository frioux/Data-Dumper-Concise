package Devel::Dwarn;

use Data::Dumper::Concise::Sugar ();

sub import {
  Data::Dumper::Concise::Sugar->export_to_level(1, @_);
}

1;
