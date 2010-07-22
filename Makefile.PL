use 5.006;
use inc::Module::Install 0.91;
use strict;
use warnings FATAL => 'all';

all_from 'lib/Data/Dumper/Concise.pm';
requires 'Devel::ArgNames' => 0.03;

WriteAll;
