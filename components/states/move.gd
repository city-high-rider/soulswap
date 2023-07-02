extends State
class_name MoveState

# this state is for simple moving around. It is intended to have only general behaviour
# for movement, hence it doesn't have any logic for swtiching to other states. Use it as a base
# for other, more specific states that DO have transitions!

# How fast do we accelerate?
@export var acceleration : float = 50

# What's our top speed?
@export var top_speed : float = 6.5

# This determines how fast we slow down.
@export var friction : float = 20

func handle_physics(delta: float) -> void:
	# Accelerate in input direction.
	user.velocity = user.velocity.move_toward(user.velocity + user.transform.basis * Vector3(user.ghost.input_direction.x, 0, -user.ghost.input_direction.y), acceleration * delta)
	
	# Make sure that we don't go too fast!
	user.velocity.x = clamp(user.velocity.x, -top_speed, top_speed)
	user.velocity.z = clamp(user.velocity.z, -top_speed, top_speed)
	
	# apply friction. Don't touch the vertical component, though.
	user.velocity = user.velocity.move_toward(Vector3(0, user.velocity.y, 0), delta * friction)
	user.move_and_slide()
	

func handle_ghost_output(action: String, payload) -> void:
	pass
