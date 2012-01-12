package Domino::Player;

use warnings;
use strict;

use Moose;

has 'bones' => (
    is => 'rw',
    isa => 'ArrayRef[Domino::Bone]',
);

sub is_empty {
    my ($self) = @_;

    return 0 == $self->size;
}

sub how_many_bones {
    my ($self) = @_;

    return $self->size;
}

sub size {
    my ($self) = @_;

    return scalar @{ $self->bones };
}

sub pop_bone {
    my ($self) = @_;

    return if $self->is_empty;

    return pop @{ $self->bones };
}

sub can_play {
    my ($self, $board) = @_;

    if ($board->is_empty and $self->how_many_bones => 0) {
        $board->place( $self->pop_bone )
    }
}


__PACKAGE__->meta->make_immutable;