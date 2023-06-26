extends State

# this state is for simple moving around.

# what idle state should we go to if we stop moving?
@export var idle_state : State

# How fast do we accelerate?
@export var acceleration : float = 10

# what's our coefficient of friction?
@export var friction : float = 0.9

func handle_physics(delta: float) -> void:
	# apply friction
	user.velocity = user.velocity.move_toward(user.velocity * friction, delta)
	user.move_and_slide()
	

func handle_ghost_output(action: String, payload) -> void:
	match action:
		"moving":
			user.velocity = user.velocity.move_toward(user.transform.basis * Vector3(payload.x, 0, -payload.y), get_physics_process_delta_time() * acceleration)
