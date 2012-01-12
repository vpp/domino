

# Game:
#     1. Start new game
#     2. Play current player
#     3. Player takes a bone from heap



use strict;
use warnings;

use Domino::Game;



my $game = Domino::Game->new( number_of_players => 2 );

$game->print_statistics;

while (not $game->game_over) {
    $game->play_current_player;
}