extends AiState

# In this state, the drone should just fly around a particular target.

# Target
var target : Shell = null
# Inputs
var inputs : GhostInput = GhostInput.new()
# current destination in global space
var destination : Vector3 = Vector3.ZERO

## How high should we be above the target?
@export var desired_elevation : float = 12

## What's considered "close enough" for height?
@export var height_moe : float = 1.5

## How far away should we fly from the target?
@export var orbit_radius : float = 12

## How long should we wait before picking a new destination point?
@export var new_destination_period_s : float = 3
var time_till_next_point = new_destination_period_s

func handle_physics(delta: float) -> void:
	time_till_next_point = max(time_till_next_point - delta, 0)
	if !target:
		get_target()
		
	if time_till_next_point <= 0:
		destination = get_new_destination()
		time_till_next_point = new_destination_period_s
	
	# Move in direction of destination
	inputs.input_direction = input_move_towards(destination)
	
	# We need to handle elevation separately.
	var elevation_delta : float = (destination.y - user.ghost_mount.shell.global_transform.origin.y)
	# reset current elevation input
	inputs.shift_depressed = false
	inputs.secondary_depressed = false
	# If there is a noticeable height discrepancy:
	if abs(elevation_delta) > height_moe:
		# float up (secondary_depressed) or down (shift_depressed) depending on if we are lower or higher.
		if sign(elevation_delta) == 1:
			inputs.secondary_depressed = true
		else:
			inputs.shift_depressed = true
	
	user.current_inputs = inputs
	
func get_new_destination() -> Vector3:
	# Pick a random point in a circle around the target and fly there.
	# Yes, it's possible to hit a wall. but we are usually flying very high above the terrain so it shouldn't
	# happen often.
	var random_angle : float = randf_range(0, TAU)
	return target.global_transform.origin + Vector3(cos(random_angle), desired_elevation, sin(random_angle)) * orbit_radius

func get_target() -> void:
	target = PlayerInfo.current_player_shell
