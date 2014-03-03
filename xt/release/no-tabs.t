use strict;
use warnings;

# this test was generated with Dist::Zilla::Plugin::NoTabsTests 0.06

use Test::More 0.88;
use Test::NoTabs;

my @files = (
    'lib/MooseX/TraitFor/Moose/Meta/Class/BetterAnonClassNames.pm',
    'lib/MooseX/Traitor.pm',
    'lib/MooseX/Util.pm',
    'lib/MooseX/Util/Meta/Class.pm'
);

notabs_ok($_) foreach @files;
done_testing;
