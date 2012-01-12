package Domino::Role::HasBones;

use warnings;
use strict;

use Moose::Role;

has 'bones' => (
    is => 'rw',
    isa => 'ArrayRef[Domino::Bone]',
    lazy_build => 1,
);

sub is_empty {
    my ($self) = @_;

    return 0 == $self->size;
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

1;