package MooseX::Util;

# ABSTRACT: The great new MooseX::Util!

use strict;
use warnings;

use parent 'Moose::Util';

use MooseX::Util::Meta::Class;

=function with_traits(<classname> => (<trait1>, ... )

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

=cut

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

=head1 SYNOPSIS

    use MooseX::Util qw{ ensure_all_roles with_traits };

    # profit!

=head1 DESCRIPTION

This is a utility module that handles all of the same functions that
L<Moose::Util> handles.  In fact, most of the functions exported by this
package are simply re-exports from L<Moose::Util>, so you're recommended to
read the documentation of that module for a comprehensive view.

However.

We've reimplemented a number of the functions our parent provides, for a
variety of reasons.  Those functions are documented here.

=head1 SEE ALSO

L<Moose::Util>

=cut
