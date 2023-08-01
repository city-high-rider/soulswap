extends MoveState
## this is a floating state that is used by drones.

## How far do we float up/down?
@export var lift_speed : float = 4

func handle_physics(delta: float) -> void:
	var inputs : GhostInput = ghost_mount.get_ghost_inputs()
	user.velocity.y = move_toward(user.velocity.y, 0, delta * 3)
	if inputs.secondary_depressed:
		user.velocity.y = lift_speed
	if inputs.shift_depressed:
		user.velocity.y = -lift_speed
		
	super(delta)
