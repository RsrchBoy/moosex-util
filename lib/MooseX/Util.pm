#
# This file is part of MooseX-Util
#
# This software is Copyright (c) 2012 by Chris Weyl.
#
# This is free software, licensed under:
#
#   The GNU Lesser General Public License, Version 2.1, February 1999
#
package MooseX::Util;
BEGIN {
  $MooseX::Util::AUTHORITY = 'cpan:RSRCHBOY';
}
# git description: 0.002-3-g0d45e2b
$MooseX::Util::VERSION = '0.003';

# ABSTRACT: Moose::Util extensions

use strict;
use warnings;

use parent 'Moose::Util';

use MooseX::Util::Meta::Class;


# TODO allow with_traits() to be curried with different class metaclasses?

sub with_traits {
    my ($class, @roles) = @_;
    return $class unless @roles;
    return MooseX::Util::Meta::Class->create_anon_class(
        superclasses => [$class],
        roles        => \@roles,
        cache        => 1,
    )->name;
}


!!42;

__END__

=pod

=encoding UTF-8

=for :stopwords Chris Weyl

=for :stopwords Wishlist flattr flattr'ed gittip gittip'ed

=head1 NAME

MooseX::Util - Moose::Util extensions

=head1 VERSION

This document describes version 0.003 of MooseX::Util - released May 22, 2014 as part of MooseX-Util.

=head1 SYNOPSIS

    use MooseX::Util qw{ ensure_all_roles with_traits };

    # profit!

=head1 DESCRIPTION

This is a utility module that handles all of the same functions that
L<Moose::Util> handles.  In fact, most of the functions exported by this
package are simply re-exports from L<Moose::Util>, so you're recommended to
read the documentation of that module for a comprehensive view.

However.

We've re-implemented a number of the functions our parent provides, for a
variety of reasons.  Those functions are documented here.

=head1 FUNCTIONS

=head2 with_traits(<classname> => (<trait1>, ... )

Given a class and one or more traits, we construct an anonymous class that is
a subclass of the given class and consumes the traits given.  This is exactly
the same as L<Moose::Util/with_traits>, except that we use
L<MooseX::Util::Meta::Class/create_anon_class> to construct the anonymous
class, rather than L<Moose::Meta::Class/create_anon_class> directly.

Essentially, this means that when we do:

    my $anon_class_name = with_traits('Zombie::Catcher', 'SomeTrait');

For $anon_class_name we get:

    Zombie::Catcher::__ANON__::SERIAL::1

Rather than:

    Moose::Meta::Class::__ANON__::SERIAL::1

This is nice because we have an idea of where the first anonymous class came
from, whereas the second one could could be from anywhere.

=head1 SEE ALSO

Please see those modules/websites for more information related to this module.

=over 4

=item *

L<Moose::Util>

=back

=head1 SOURCE

The development version is on github at L<http://https://github.com/RsrchBoy/moosex-util>
and may be cloned from L<git://https://github.com/RsrchBoy/moosex-util.git>

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website
https://github.com/RsrchBoy/moosex-util/issues

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=head1 AUTHOR

Chris Weyl <cweyl@alumni.drew.edu>

=head2 I'm a material boy in a material world

=begin html

<a href="https://www.gittip.com/RsrchBoy/"><img src="https://raw.githubusercontent.com/gittip/www.gittip.com/master/www/assets/%25version/logo.png" /></a>
<a href="http://bit.ly/rsrchboys-wishlist"><img src="http://wps.io/wp-content/uploads/2014/05/amazon_wishlist.resized.png" /></a>
<a href="https://flattr.com/submit/auto?user_id=RsrchBoy&url=https%3A%2F%2Fgithub.com%2FRsrchBoy%2Fmoosex-util&title=RsrchBoy's%20CPAN%20MooseX-Util&tags=%22RsrchBoy's%20MooseX-Util%20in%20the%20CPAN%22"><img src="http://api.flattr.com/button/flattr-badge-large.png" /></a>

=end html

Please note B<I do not expect to be gittip'ed or flattr'ed for this work>,
rather B<it is simply a very pleasant surprise>. I largely create and release
works like this because I need them or I find it enjoyable; however, don't let
that stop you if you feel like it ;)

L<Flattr this|https://flattr.com/submit/auto?user_id=RsrchBoy&url=https%3A%2F%2Fgithub.com%2FRsrchBoy%2Fmoosex-util&title=RsrchBoy's%20CPAN%20MooseX-Util&tags=%22RsrchBoy's%20MooseX-Util%20in%20the%20CPAN%22>,
L<gittip me|https://www.gittip.com/RsrchBoy/>, or indulge my
L<Amazon Wishlist|http://bit.ly/rsrchboys-wishlist>...  If you so desire.

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2012 by Chris Weyl.

This is free software, licensed under:

  The GNU Lesser General Public License, Version 2.1, February 1999

=cut
