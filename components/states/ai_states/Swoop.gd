extends AiState

## this is the state where the drone swoops down and fires a volley at the player.

## How high should we be above the player before we fire?
@export var attack_height : float = 8

## Which state should we revert back to when we're done firing?
@export var fly_state : AiState

var target : Shell = null
var inputs : GhostInput = GhostInput.new()

func handle_physics(delta: float) -> void:
	target = PlayerInfo.current_player_shell
	if !target:
		return
		
	# Ascend or descend depending on height.
	var desired_height_delta : float = target.global_transform.origin.y - user.global_transform.origin.y + attack_height
	inputs.secondary_depressed = false
	inputs.shift_depressed = false
	if sign(desired_height_delta) == 1:
		inputs.secondary_depressed = true
	else:
		inputs.shift_depressed = true
	
	# Move toward player
	inputs.input_direction = input_move_towards(target.global_transform.origin)
	user.current_inputs = inputs
	
	# aim and fire!
	inputs.mouse_direction = aim_at(target.global_transform.origin, PI/2, PI/2, delta)
	inputs.primary_depressed = false
	if abs(desired_height_delta) <= 1.5:
		inputs.primary_depressed = true
		get_tree().create_timer(1.8).timeout.connect(func(): state_machine.switch_state(fly_state))
