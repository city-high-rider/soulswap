extends AiState
class_name AiPursuitState
# This is a state that just makes the enemy beeline towards the player.

# Link to the navigation agent that we are using.
@export var nav_agent : NavigationAgent3D

# What's our target?
var target : Shell

# How often should we request a new path?
@export var new_path_poll_rate_seconds : float = 0.4

var time_until_new_path : float = new_path_poll_rate_seconds

func handle_physics(delta: float) -> void:
	time_until_new_path -= delta
	if time_until_new_path <= 0 and target:
		time_until_new_path = new_path_poll_rate_seconds
		nav_agent.set_target_position(target.global_transform.origin)
	
	var user_inputs : GhostInput = user.current_inputs	
		
	if is_instance_valid(target):
		var next_location : Vector3 = nav_agent.get_next_path_position()
		user_inputs.input_direction = input_move_towards(next_location)
		# Let's look at the player while we're at it.
		user_inputs.mouse_direction = look_towards_y(target.global_transform.origin, PI, delta)
	else:
		user_inputs.input_direction = Vector2.ZERO
		user_inputs.mouse_direction = Vector2.ZERO
		target = PlayerInfo.current_player_shell

