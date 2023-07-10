extends StateMachine
class_name BodyStateMachine

# this is a state machine that is used to control bodies using the input of a ghost.

# Which mount is the ghost connected to?
@export var ghost_mount : GhostMount

# What is our current ghost?
func _ready() -> void:
	ghost_mount.ghost_changed.connect(_on_ghost_changed)
	
func _on_ghost_changed(new_ghost: Ghost, _is_player: bool) -> void:
	pass
