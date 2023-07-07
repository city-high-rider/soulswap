@tool
extends Node3D
class_name AudioQueue3D

# This class is like a regular player, but it can play sounds over top of each
# other without cutting off sounds. Useful for something like footsteps or gunshots.

# How many players do we have (I.e how many sounds can we play at once)?
# 0 wouldn't make sense, 1 would be no different to a regular player so we
# set the minimum to 2. Max of 10 is arbitrarily chosen.
@export_range(2, 10, 1) var depth : int = 5

# The list of players that are our children
var players : Array[AudioStreamPlayer3D]

# Index of the next player that we will try and play.
var next_index : int = 0

# Is the player setup correctly?
var setup_correctly : bool = true

func _ready() -> void:
	var first_child = get_child(0)
	if !first_child is AudioStreamPlayer3D:
		setup_correctly = false
	for i in range(depth):
		var new_player = first_child.duplicate()
		add_child(new_player)
		players.append(new_player)
		

func play_sound() -> void:
	if !setup_correctly:
		return
	if !players[next_index].playing:
		players[next_index].play()
		next_index += 1
		# Make sure that we don't go out of array bounds
		next_index %= len(players)

func _get_configuration_warnings() -> PackedStringArray:
	if !get_child(0) is AudioStreamPlayer3D:
		return ["First child must be AudioStreamPlayer3D."] 
	else:
		return []
