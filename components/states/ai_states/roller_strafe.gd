extends AiState
# This strafe state will circle around a point, until the target gets too far away.

# How long (roughly) until we change strafe direction?
@export var change_direction_time : float = 1

# Which pursuit state should we revert back to if the target is out of range?
@export var pursuit_state : AiState

# How far away can the player get before we start chasing them again?
@export var break_strafe_distance : float = 5

# Who's our target?
var target : Shell

# which direction are we currently strafing? Either 1 or -1.
var current_strafe_direction : int = 1

# How long until we change direction?
var time_until_change_direction : float = change_direction_time

func enter() -> void:
	user.primary_depressed = true
	target = PlayerInfo.current_player_shell
	
func exit() -> void:
	user.primary_depressed = false

func handle_physics(delta: float) -> void:
	if !is_instance_valid(target):
		target = PlayerInfo.current_player_shell
	time_until_change_direction -= delta
	if time_until_change_direction <= 0:
		time_until_change_direction = change_direction_time
		current_strafe_direction *= -1
		
	user.mouse_direction = look_towards_y(target.global_transform.origin, 3* PI/2, delta)
	user.input_direction = Vector2(current_strafe_direction, 0)
	

	if user.global_transform.origin.distance_to(target.global_transform.origin) > break_strafe_distance:
		state_machine.switch_state(pursuit_state)
