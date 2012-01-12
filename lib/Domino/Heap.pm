package Domino::Heap;

use warnings;
use strict;

use Moose;
use List::Util qw/shuffle/;
use Domino::Bone;

with 'Domino::Role::HasBones';

sub _build_bones {
    my ($self) = @_;

    my @bones;

    foreach my $i (1..6) {
        foreach my $j (1..6) {
            push @bones, Domino::Bone->new( score_left => $i, score_right => $j, );
        }
    }

    return [ shuffle @bones ];
}

__PACKAGE__->meta->make_immutable;