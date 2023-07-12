extends Node

# this is a global singleton that stores information about the player, such as the position.
# This stops me from having to do stuff like get all the AI ghosts in the tree and set their target
# to the player. they can just do that themselves.
# Note: this script assumes there is only one player!

# Which body is the player currently controlling?
var current_player_shell : Shell
