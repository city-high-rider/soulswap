extends State
## State that controls how the shell moves. Has access to a ghost.
class_name ShellState

# Which ghost mount are we getting inputs from?
var ghost_mount : GhostMount

func handle_ghost_input(action: String, payload) -> void:
	pass
