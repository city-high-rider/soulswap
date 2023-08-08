extends AiState

## this behaviour is for the drone when it swoops down to buff an enemy.

## Path to flying state
@export var fly_state : AiState

## How close should we be to the target before we start descending?
@export var lower_distance : float = 4

## Which buff are we applying?
@export var drone_buff : PackedScene

# Target is who we are going to apply the buff to.
var target : Shell = null


func enter() -> void:
	target = pick_random_target()
	# If we can't find a target we should exit
	if target == null:
		state_machine.switch_state(fly_state)
		

func handle_physics(delta: float) -> void:
	if !target:
		target = pick_random_target()
		# Again, we should exit if we can't find a valid target.
		if target == null:
			state_machine.switch_state(fly_state)
			return
	
	# Handle moving towards the target.
	user.current_inputs.input_direction = input_move_towards(target.global_transform.origin * Vector3(1,0,1))
	# Look at them as well
	user.current_inputs.mouse_direction = aim_at(target.global_transform.origin, PI/6, PI/6, delta)
	
	# If we're close enough horizontally start lowering
	if (user.global_transform.origin * Vector3(1,0,1)).distance_to(target.global_transform.origin * Vector3(1,0,1)) <= lower_distance:
		var desired_height_delta : float = target.global_transform.origin.y - user.global_transform.origin.y
		user.current_inputs.secondary_depressed = false
		user.current_inputs.shift_depressed = false
		if sign(desired_height_delta) == 1:
			user.current_inputs.secondary_depressed = true
		else:
			user.current_inputs.shift_depressed = true
	
	if abs(target.global_transform.origin.y - user.global_transform.origin.y) <= 5:
		state_machine.switch_state(fly_state)
		if "buff_manager" in target and drone_buff:
			target.buff_manager.apply_buff(drone_buff.instantiate())
	


func pick_random_target() -> Shell:
	# make sure we don't pick the player or ourselves
	var options : Array[Node] = get_tree().get_nodes_in_group("shells").filter(func(s): return s != PlayerInfo.current_player_shell and s != self and s.ghost_mount.ghost)
	return null if len(options) == 0 else options[randi() % len(options)]
