extends State
# This is a state that just makes the enemy beeline towards the player.

# Link to the navigation agent that we are using.
@export var nav_agent : NavigationAgent3D

# What's our target? Hard coded for now
@export var target : Shell

func handle_physics(delta: float) -> void:
	var next_location : Vector3 = nav_agent.get_next_path_position()
	# that function gives us a path position in global space, but we need it in local space.
	var next_velocity : Vector3 = user.to_local(next_location)
	user.input_direction = Vector2(next_velocity.x, -next_velocity.z).normalized()
	
	# Let's look at the player while we're at it.
	look_towards(target.global_transform.origin, delta)

func _on_target_update_timer_timeout():
	nav_agent.set_target_position(target.global_transform.origin)
	
func look_towards(pos: Vector3, delta: float) -> void:
	var local_pos : Vector3 = user.to_local(pos)
	var y_angle : float = Vector3.FORWARD.angle_to(local_pos * Vector3(1, 0, 1)) * sign(local_pos.x)
	user.mouse_direction = Vector2(sign(y_angle) * min(delta * rad_to_deg(TAU), abs(rad_to_deg(y_angle))),0)
