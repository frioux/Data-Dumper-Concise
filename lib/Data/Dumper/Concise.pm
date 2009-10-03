package Data::Dumper::Concise;

use 5.006;

$VERSION = '1.000';

require Exporter;
require Data::Dumper;

BEGIN { @ISA = qw(Exporter) }

@EXPORT = qw(Dumper);

my $USAGE = 'Dumper() to get an object or Dumper($ref) to dump a reference please';

sub Dumper {
  die $USAGE if @_ > 1;
  my $dd = Data::Dumper->new([]);
  $dd->Terse(1)->Indent(1)->Useqq(1)->Deparse(1)->Quotekeys(0)->Sortkeys(1);
  return $dd unless @_;
  my $ref = $_[0];
  die $USAGE unless ref($ref);
  return $dd->Values([ $ref ])->Dump;
}

=head1 NAME

Data::Dumper::Concise - Less indentation and newlines plus sub deparsing

=head1 SYNOPSIS

  use Data::Dumper::Concise;

  warn Dumper($var);

is equivalent to:

  use Data::Dumper;
  {
    local $Data::Dumper::Terse = 1;
    local $Data::Dumper::Indent = 1;
    local $Data::Dumper::Useqq = 1;
    local $Data::Dumper::Deparse = 1;
    local $Data::Dumper::Quotekeys = 0;
    local $Data::Dumper::Sortkeys = 1;
    warn Dumper($var);
  }

whereas

  my $dd = Dumper;

is equivalent to:

  my $dd = Data::Dumper->new([])
                       ->Terse(1)
                       ->Indent(1)
                       ->Useqq(1)
                       ->Deparse(1)
                       ->Quotekeys(0)
                       ->Sortkeys(1);

So for the structure:

  { foo => "bar\nbaz", quux => sub { "fleem" } };

Data::Dumper::Concise will give you:

  {
    foo => "bar\nbaz",
    quux => sub {
        use warnings;
        use strict 'refs';
        'fleem';
    }
  }

instead of the default Data::Dumper output:

  $VAR1 = {
  	'quux' => sub { "DUMMY" },
  	'foo' => 'bar
  baz'
  };

(note the tab indentation, oh joy ...)

=head1 DESCRIPTION

This module always exports a single function, Dumper, which can be called
with a single reference value to dump that value or with no arguments to
return the Data::Dumper object it's created.

It exists, fundamentally, as a convenient way to reproduce a set of Dumper
options that we've found ourselves using across large numbers of applications,
primarily for debugging output.

Why is deparsing on when the aim is concision? Because you often want to know
what subroutine refs you have when debugging and because if you were planning
to eval this back in you probably wanted to remove subrefs first and add them
back in a custom way anyway. Note that this -does- force using the pure perl
Dumper rather than the XS one, but I've never in my life seen Data::Dumper
show up in a profile so "who cares?".

=head1 AUTHOR

Matt S. Trout <mst@shadowcat.co.uk>

=head1 CONTRIBUTORS

None required yet. Maybe this module is perfect (hahahahaha ...).

=head1 COPYRIGHT

Copyright (c) 2009 the Data::Dumper::Concise L</AUTHOR> and L</CONTRIBUTORS>
as listed above.

=head1 LICENSE

This library is free software and may be distributed under the same terms
as perl itself.

=cut

1;
