extends State
# This is a state that just makes the enemy beeline towards the player.

# Link to the navigation agent that we are using.
@export var nav_agent : NavigationAgent3D

# What's our target? Hard coded for now
@export var target : Shell

# How often should we request a new path?
@export var new_path_poll_rate_seconds : float = 0.4

var time_until_new_path : float = new_path_poll_rate_seconds

func handle_physics(delta: float) -> void:
	time_until_new_path -= delta
	if time_until_new_path <= 0 and target:
		time_until_new_path = new_path_poll_rate_seconds
		nav_agent.set_target_position(target.global_transform.origin)
		
	if target:
		var next_location : Vector3 = nav_agent.get_next_path_position()
		user.input_direction = input_move_towards(next_location)
		# Let's look at the player while we're at it.
		look_towards(target.global_transform.origin, delta)
	else:
		user.input_direction = Vector2.ZERO
		user.mouse_direction = Vector2.ZERO
	
	
func look_towards(pos: Vector3, delta: float) -> void:
	var local_pos : Vector3 = user.to_local(pos)
	var y_angle : float = Vector3.FORWARD.angle_to(local_pos * Vector3(1, 0, 1)) * sign(local_pos.x)
	user.mouse_direction = Vector2(sign(y_angle) * min(delta * rad_to_deg(TAU), abs(rad_to_deg(y_angle))),0)
	
func input_move_towards(destination: Vector3) -> Vector2:
	# that function gives us a path position in global space, but we need it in local space.
	var next_velocity : Vector3 = user.to_local(destination)
	return Vector2(next_velocity.x, -next_velocity.z).normalized()
