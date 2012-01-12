package Domino::Board;

use warnings;
use strict;

use Moose;

has 'bones' => (
    is => 'rw',
);

has 'left_side' => (
    is => 'rw',
    default => 0,
);

has 'right_side' => (
    is => 'rw',
    default => 0,
);

# sub 


__PACKAGE__->meta->make_immutable;