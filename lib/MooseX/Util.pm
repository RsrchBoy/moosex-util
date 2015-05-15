package MooseX::Util;

# ABSTRACT: Moose::Util extensions

use strict;
use warnings;

use parent 'Moose::Util';

use Sub::Exporter::Progressive -setup => {
    exports => [
        qw{
            add_method_modifier
            apply_all_roles
            does_role
            english_list
            ensure_all_roles
            find_meta
            get_all_attribute_values
            get_all_init_args
            is_role
            meta_attribute_alias
            meta_class_alias
            resolve_metaclass_alias
            resolve_metatrait_alias
            search_class_by_role
            throw_exception
            with_traits
        },

        # and our own...
        qw{
            is_private
        },
    ],
    groups => { default => [ ':all' ] },
};

use Carp 'confess';
use MooseX::Util::Meta::Class;

=func with_traits(<classname> => (<trait1>, ... ))

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

=head2 is_private

    # true if "private"
    ... if is_private('_some_name');

Ofttimes we need to determine if a name is considered "private" or not.  By convention,
method, attribute, and other names are considered private if their first character is
an underscore.

While trivial to test for, this allows us to centralize the tests in one place.

=cut

sub is_private($) {
    my ($name) = @_;

    confess 'is_private() must be called with a name to test!'
        unless $name;

    return 1 if $name =~ /^_/;
    return;
}

sub find_meta { goto \&Moose::Util::find_meta }

!!42;
__END__

=for Pod::Coverage find_meta

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

=head1 SEE ALSO

L<Moose::Util>

=cut
