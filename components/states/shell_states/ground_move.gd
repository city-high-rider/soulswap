extends MoveState

# State specifically for grounded movement, that can jump and fall etc.

## Which state to transition to when we fall?
@export var fall_state : AirState

## How high do we jump?
@export_range(0,10,0.1) var jump_height : float = 2

func handle_physics(delta: float) -> void:
	super(delta)
	if !user.is_on_floor():
		state_machine.switch_state(fall_state)

func handle_ghost_output(action: String, _payload) -> void:
	match action:
		"jump":
			user.velocity.y += jump_height
			state_machine.switch_state(fall_state)
