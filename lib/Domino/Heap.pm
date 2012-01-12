package Domino::Heap;

use warnings;
use strict;

use Moose;
use List::Util qw/shuffle/;
use Domino::Bone;

has 'bones' => (
    is => 'ro',
    isa => 'ArrayRef[Domino::Bone]',
    lazy_build => 1,
);


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

__PACKAGE__->meta->make_immutable;