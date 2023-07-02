extends State
# This is a state that just makes the enemy beeline towards the player.

# Link to the navigation agent that we are using.
@export var nav_agent : NavigationAgent3D

# What's our target? Hard coded for now
@export var target : Shell

func handle_physics(_delta: float) -> void:
	var current_location : Vector3 = user.global_transform.origin
	var next_location : Vector3 = nav_agent.get_next_path_position()
	# Where we're going to go is our velocity times the basis. So we need to multiply by inverse basis when we are converting to inputs.
	var next_velocity : Vector3 = (next_location - current_location) * user.global_transform.basis.inverse()
	user.input_direction = Vector2(-next_velocity.x, next_velocity.z).normalized()

func _on_target_update_timer_timeout():
	nav_agent.set_target_position(target.global_transform.origin)
