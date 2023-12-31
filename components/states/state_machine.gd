extends Node
class_name StateMachine

# this class is a state manager for a state machine. It delegates logic from 
# process functions and inputs to its children.

# what is this state machine controlling?
var user : Node = null

# What is the initial state of this state machine?
@export var initial_state : State

# What is the current state?
var current_state : State

signal switched_state(new_state: String)

# Function for switching states.
func switch_state(new_state: State) -> void:
	if current_state:
		current_state.exit()
	current_state = new_state
	current_state.enter()
	emit_signal("switched_state", str(current_state))
	
# Start the state machine.
func init(new_user: Node) -> void:
	user = new_user
	current_state = initial_state
	# set the user and state maanger of the children state nodes.
	for state in get_children().filter(func(c): if c is State: return true else: return false):
		state.user = user
		state.state_machine = self

# function that should be called on the user's physics process
func handle_physics(delta: float) -> void:
	if !is_instance_valid(current_state):
		return
	current_state.handle_physics(delta)
	
# function that should be called on the user's process
func handle_process(delta: float) -> void:
	current_state.handle_process(delta)
