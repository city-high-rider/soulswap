extends MoveState
class_name AirState

# A state that handles aerial movement, such as falling and jumping. This state is meant to have
# only general air related movement, and hence doesn't implement any logic for switching states.
# Feel free to use it as a base for other, more specific states that DO have transitions!

# How fast do we fall down?
@export_range(-30,0,0.1) var gravity : float = -4

func handle_physics(delta: float) -> void:
	user.velocity.y += gravity * delta
	super(delta)
