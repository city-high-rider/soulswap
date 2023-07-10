extends State
class_name ShellState

# State that controls how the shell moves. Has access to a ghost.

# Which ghost are we reading inputs from? Set at runtime.
var ghost : Ghost

func handle_ghost_input(action: String, payload) -> void:
	pass
