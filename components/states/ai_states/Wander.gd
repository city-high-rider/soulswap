extends AiState

## Wandering behaviour for the revenant ghost

var target : Shell = null

## How close can the target get before we move away?
@export var retreat_distance : float = 5

## Link to the navigation agent.
@export var nav_agent : NavigationAgent3D

## How long do we wait before shooting again?
@export var shot_period_s : float = 2
var current_shot_cooldown : float = shot_period_s + randf_range(0, 1.5)

func enter() -> void:
	target = get_target()
	
func handle_physics(delta: float) -> void:
	target = get_target()
	if !target || !nav_agent:
		return
		
	# If the target is too close to us, move away. 
	if user.global_transform.origin.distance_to(target.global_transform.origin) <= retreat_distance:
		pass
	
	# Shoot at the player.
	current_shot_cooldown = max(current_shot_cooldown - delta, 0)
	user.current_inputs.primary_depressed = false
	
	var shot_travel_time : float = (target.global_transform.origin - user.global_transform.origin).length() / 20
	user.current_inputs.mouse_direction = aim_at(target.global_transform.origin + target.velocity * shot_travel_time, PI/2, PI/2, delta)
	if current_shot_cooldown <= 0:
		current_shot_cooldown = shot_period_s + randf_range(0, 1.8)
		user.current_inputs.primary_depressed = true
		
	
func get_target() -> Shell:
	return PlayerInfo.current_player_shell if PlayerInfo.current_player_shell else null
