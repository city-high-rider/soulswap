extends Node

# this is a global singleton that stores information about the player, such as the position.
# This stops me from having to do stuff like get all the AI ghosts in the tree and set their target
# to the player. they can just do that themselves.
# Note: this script assumes there is only one player!

# Which body is the player currently controlling?
var current_player_shell : Shell


# Which body was the player controlling when they hit the checkpoint?
var last_saved_player_shell : Shell

func _ready() -> void:
	CheckpointManager.checkpoint_activated.connect(save_data)
	CheckpointManager.load_checkpoint.connect(load_data)
	save_data()
	

func save_data() -> void:
	last_saved_player_shell = current_player_shell

func load_data() -> void:
	# last saved player shell isn't actually set correctly initially.. but this will at least 
	# stop the game from crashing.
	if last_saved_player_shell:
		print_debug(str(last_saved_player_shell) + " " + str(current_player_shell))
		last_saved_player_shell.ghost_mount.change_ghost(current_player_shell.ghost_mount.ghost)
		current_player_shell = last_saved_player_shell
