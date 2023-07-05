extends MoveState

# State specifically for grounded movement, that can jump and fall etc.

# Which state to transition to when we fall?
@export var fall_state : AirState

func handle_physics(delta: float) -> void:
	super(delta)
	if !user.is_on_floor():
		state_machine.switch_state(fall_state)

func handle_ghost_output(action: String, _payload) -> void:
	match action:
		"jump":
			user.velocity.y += 10
			state_machine.switch_state(fall_state)
