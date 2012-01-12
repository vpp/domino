package Domino::Bone;

use warnings;
use strict;

use Moose;

has 'score_left' => (
    is => 'ro',
);

has 'score_right' => (
    is => 'ro',
);

__PACKAGE__->meta->make_immutable;