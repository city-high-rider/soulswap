extends AiPursuitState

# This is much like the pursuit state, but we strafe around the player when we get close.

# Path to the strafing state:
@export var strafe_state : AiState

# How close do we have to get to the player (in meters) before we start strafing?
@export var strafe_distance_m : float = 4

func enter() -> void:
	nav_agent.target_desired_distance = strafe_distance_m

func handle_physics(delta: float) -> void:
	super(delta)
	# This is sort of a hack, because navigation agent isn't calling the function
	if user.global_transform.origin.distance_to(target.global_transform.origin) <= strafe_distance_m:
		_on_navigation_agent_3d_target_reached()

func _on_navigation_agent_3d_target_reached():
	state_machine.switch_state(strafe_state)
