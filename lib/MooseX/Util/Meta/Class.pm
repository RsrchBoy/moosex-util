package MooseX::Util::Meta::Class;

# ABSTRACT: A helper metaclass

use Moose;
use namespace::autoclean;
use MooseX::AttributeShortcuts;

extends 'Moose::Meta::Class';
with 'MooseX::TraitFor::Meta::Class::BetterAnonClassNames';

# NOTE: making this package immutable breaks our metaclass compatibility!
#__PACKAGE__->meta->make_immutable;
!!42;
__END__

=head1 SYNOPSIS

    # create a new type of Zombie catcher equipped with machete and car
    my $meta = MooseX::Util::Meta::Class->create_anon_class(
        'Zombie::Catcher' => qw{
            Zombie::Catcher::Tools::Machete
            Zombie::Catcher::Tools::TracyChapmansFastCar
         },
     );

    # created anon classname is: Zombie::Catcher::__ANON__::SERIAL::42

=head1 DESCRIPTION

This is a trivial extension of L<Moose::Meta::Class> that consumes the
L<BetterAnonClassNames|MooseX::TraitFor::Meta::Class::BetterAnonClassNames>
trait.

=cut
