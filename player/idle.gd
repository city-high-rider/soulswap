extends State

# This is an idle state, when the body isn't doing anything.

# What state should we transition to when we want to move?
@export var move_state : State

func handle_physics(delta: float) -> void:
	# Slow down a bit.
	user.velocity.x = move_toward(user.velocity.x, 0, delta)
	user.velocity.z = move_toward(user.velocity.z, 0, delta)
	user.move_and_slide()


func handle_ghost_output(action: String, payload):
	pass
