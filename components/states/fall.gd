extends AirState

# Player specific fall state

# what's the move state to transition to when we hit the floor?
@export var move_state : MoveState

func handle_physics(delta: float) -> void:
	super(delta)
	if user.is_on_floor():
		state_machine.switch_state(move_state)
