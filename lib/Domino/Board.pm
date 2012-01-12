package Domino::Board;

use warnings;
use strict;

use Moose;

with 'Domino::Role::HasBones';

has 'left_side' => (
    is => 'rw',
    default => 0,
);

has 'right_side' => (
    is => 'rw',
    default => 0,
);

sub _build_bones {
    my ($self) = @_;

    return [];
}

__PACKAGE__->meta->make_immutable;