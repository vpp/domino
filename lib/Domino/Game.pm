package Domino::Game;

use strict;
use warnings;

use List::MoreUtils;
use Moose;
# use Moose::Types;

use Domino::Player;
use Domino::Heap;
use Domino::Board;

has 'number_of_players' => (
    is => 'ro',
    default => 2,
);

has 'heap' => (
    is => 'ro',
    isa => 'Domino::Heap',
    lazy_build => 1,
);

has 'board' => (
    is => 'ro',
    isa => 'Domino::Board',
    lazy_build => 1,
);

has 'players' => (
    is => 'rw',
    lazy_build => 1,
    isa => 'ArrayRef[Domino::Player]'
);

has '_current_player_index' => (
    is => 'rw',
    default => 0,
);

sub _build_heap {
    my ($self) = @_;

    return Domino::Heap->new();
}

sub _build_board {
    my ($self) = @_;

    return Domino::Board->new();
}

sub _build_players {
    my ($self) = @_;

    return [
        map {
            Domino::Player->new(bones => [map {$self->heap->pop_bone} 1..6])
        } 1..$self->number_of_players
    ];
}

sub game_over {
    my ($self) = @_;

    return $self->heap->is_empty and $self->there_is_a_winner;
}

sub there_is_a_winner {
    my ($self) = @_;

    return 1 == grep { $_->can_play( $self->board ) } @{ $self->players };
}

sub play_current_player {
    my ($self) = @_;

    my $player = $self->players->[ $self->_current_player_index ];

    # user have bones to perform turn
    if ($player->can_play( $self->board )) {
        $player->play( $self->board );

    # no more bones in heap
    } elsif (not $self->heap->is_empty) {
        $player->take_bone( $self->heap->pop_bone );
    } else {
        $player->quit_game
    }


    $self->switch_player();
}

sub switch_player {
    my ($self) = @_;

    return unless $self->there_is_a_winner;

    do {
        if (1 + $self->_current_player_index == $self->number_of_players) {
            $self->_current_player_index(0);
        } else {
            $self->_current_player_index( 1 + $self->_current_player_index )
        }
    } while $self->players->[ $self->_current_player_index ]->can_play( $self->board );

}

sub print_statistics {
    my ($self) = @_;

    print "\nHere is a statistics for current game:",
        "\n  number of players: " . $self->number_of_players,
        "\n  bones in heap: " . $self->heap->size,
        map( {"\n  player with " . $_->how_many_bones . " bones"} @{ $self->players }),
        "\n";
}


__PACKAGE__->meta->make_immutable;