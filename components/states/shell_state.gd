extends State
## State that controls how the shell moves. Has access to a ghost.
class_name ShellState

# We are using an export, but it might make more sense (and be more convenient)
# later down the line to have the BodyStateMachine expose this and set it at runtime.
## which state do we transition to when our health drops to zero?
@export var down_state : ShellState

# Which ghost are we reading inputs from? Set at runtime.
var ghost : Ghost

func handle_ghost_input(action: String, payload) -> void:
	pass

# this is the most convenient place to check for death, because we don't need to 
# copy this code over a bunch of different states.
func _on_health_component_died() -> void:
	state_machine.change_state(down_state)
