package Data::Dumper::Concise::Sugar;

use 5.006;

use Exporter ();
use Data::Dumper::Concise ();
use Devel::ArgNames;

BEGIN { @ISA = qw(Exporter) }

@EXPORT = qw(Dwarn DwarnS DwarnL DwarnN);

sub Dwarn { return DwarnL(@_) if wantarray; DwarnS($_[0]) }

sub DwarnL { warn Data::Dumper::Concise::Dumper @_; @_ }

sub DwarnS ($) { warn Data::Dumper::Concise::Dumper $_[0]; $_[0] }

sub DwarnN ($) {
   my $x = arg_names();
   warn(($x?$x:'(anon)') . ' => ' . Data::Dumper::Concise::Dumper $_[0]); $_[0]
}

=head1 NAME

Data::Dumper::Concise::Sugar - return Dwarn @return_value

=head1 SYNOPSIS

  use Data::Dumper::Concise::Sugar;

  return Dwarn some_call(...)

is equivalent to:

  use Data::Dumper::Concise;

  if (wantarray) {
     my @return = some_call(...);
     warn Dumper(@return);
     return @return;
  } else {
     my $return = some_call(...);
     warn Dumper($return);
     return $return;
  }

but shorter. If you need to force scalar context on the value,

  use Data::Dumper::Concise::Sugar;

  return DwarnS some_call(...)

is equivalent to:

  use Data::Dumper::Concise;

  my $return = some_call(...);
  warn Dumper($return);
  return $return;

If you need to force list context on the value,

  use Data::Dumper::Concise::Sugar;

  return DwarnL some_call(...)

is equivalent to:

  use Data::Dumper::Concise;

  my @return = some_call(...);
  warn Dumper(@return);
  return @return;

=head1 DESCRIPTION

  use Data::Dumper::Concise::Sugar;

will import Dwarn, DwarnL, and DwarnS into your namespace. Using L<Exporter>, so see
its docs for ways to make it do something else.

=head2 Dwarn

  sub Dwarn { return DwarnL(@_) if wantarray; DwarnS($_[0]) }

=head2 DwarnL

  sub Dwarn { warn Data::Dumper::Concise::Dumper @_; @_ }

=head2 DwarnS

  sub DwarnS ($) { warn Data::Dumper::Concise::Dumper $_[0]; $_[0] }

=head1 TIPS AND TRICKS

=head2 global usage

Instead of always just doing:

  use Data::Dumper::Concise::Sugar;

  Dwarn ...

We tend to do:

  perl -MData::Dumper::Concise::Sugar foo.pl

(and then in the perl code:)

  ::Dwarn ...

That way, if you leave them in and run without the
C<< use Data::Dumper::Concise::Sugar >> the program will fail to compile and
you are less likely to check it in by accident.  Furthmore it allows that
much less friction to add debug messages.

=head2 method chaining

One trick which is useful when doing method chaining is the following:

  my $foo = Bar->new;
  $foo->bar->baz->Data::Dumper::Concise::Sugar::DwarnS->biff;

which is the same as:

  my $foo = Bar->new;
  (DwarnS $foo->bar->baz)->biff;

=head1 SEE ALSO

You probably want L<Devel::Dwarn>, it's the shorter name for this module.

=cut

1;
