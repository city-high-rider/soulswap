extends Node
class_name State

# this ia the base class for states that are used by the state machine class.

# What is the state machine that this state belongs to? (this is set by the state
# machine at runtime.)
var state_machine : StateMachine

# What is the user of the state machine? This is set at runtime.
var user : Node

# Function that's called when the state machine switches to this state.
func enter() -> void:
	pass
	
# Function that's called when the state machine switches out of this state.
func exit() -> void:
	pass
	
# Function that runs on physics process. 
func handle_physics(delta: float) -> void:
	pass

# Function that is called every _process cycle.
func handle_process(delta: float) -> void:
	pass
	
# Input is passed to this function.
func handle_input(event: InputEvent) -> void:
	pass
