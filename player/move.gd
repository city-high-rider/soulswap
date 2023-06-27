extends State

# this state is for simple moving around.

# what idle state should we go to if we stop moving?
@export var idle_state : State

# How fast do we accelerate?
@export var acceleration : float = 22

# What's our top speed?
@export var top_speed : float = 6

# This determines how fast we slow down.
@export var friction : float = 10

func handle_physics(delta: float) -> void:
	# Accelerate in input direction.
	user.velocity = user.velocity.move_toward(user.velocity + user.transform.basis * Vector3(user.ghost.input_direction.x, 0, -user.ghost.input_direction.y), acceleration * delta)
	
	# Make sure that we don't go too fast!
	user.velocity.x = clamp(user.velocity.x, -top_speed, top_speed)
	user.velocity.z = clamp(user.velocity.z, -top_speed, top_speed)
	
	# apply friction
	user.velocity = user.velocity.move_toward(Vector3.ZERO, delta * friction)
	user.move_and_slide()
	

func handle_ghost_output(action: String, payload) -> void:
	pass
