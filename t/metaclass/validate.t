use strict;
use warnings;

use Test::More;
use Test::Moose::More;

use aliased 'MooseX::TraitFor::Moose::Meta::Class::BetterAnonClassNames'
    => 'MetaTrait';
use aliased 'MooseX::Util::Meta::Class'
    => 'MetaClass';

validate_class MetaClass, (
    isa => [ qw{ Moose::Meta::Class } ],
    does => [ MetaTrait ],
    attributes => [
        is_anon => {
            -isa     => [ qw{ Moose::Meta::Attribute } ],
            reader   => 'is_anon',
            init_arg => 'is_anon',
            isa      => 'Bool',
            default  => 0,
        },
    ],
);

done_testing;
