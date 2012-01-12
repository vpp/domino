package Domino::Player;

use warnings;
use strict;

use Moose;

with 'Domino::Role::HasBones';

sub is_empty {
    my ($self) = @_;

    return 0 == $self->size;
}

sub how_many_bones {
    my ($self) = @_;

    return $self->size;
}

sub can_play {
    my ($self, $board) = @_;

    if ($board->is_empty and $self->how_many_bones => 0) {
        $board->place( $self->pop_bone )
    }
}

__PACKAGE__->meta->make_immutable;