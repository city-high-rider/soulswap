extends MoveState
class_name AirState

# A state that handles aerial movement, such as falling and jumping.

# How fast do we fall down?
@export_range(-10,0,0.1) var gravity : float = -4

# Which state should we swtich to when we are on the ground?
@export var ground_state : State

func handle_physics(delta: float) -> void:
	user.velocity.y = move_toward(user.velocity.y, user.velocity.y + gravity, delta)
	if user.is_on_ground():
		state_machine.switch_state(ground_state)
