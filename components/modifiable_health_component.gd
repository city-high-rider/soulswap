extends HealthComponent
## This is a health component that uses the ghost possession modifiers.

## Which ghost mount are we reading from?
@export var ghost_mount : GhostMount

var original_max_hp : float = max_health

func _ready() -> void:
	recalibrate_max_health(ghost_mount.get_ghost_modifiers().max_health_multiplier)
	super()
	ghost_mount.ghost_changed.connect(func (_new_ghost, _is_player): recalibrate_max_health(ghost_mount.get_ghost_modifiers().max_health_multiplier))
	ghost_mount.ghost_cleared.connect(func(): recalibrate_max_health(1))
	
func recalibrate_max_health(new_multiplier : float) -> void:
	var old_max_health : float = max_health
	max_health = original_max_hp * new_multiplier
	current_health = current_health / old_max_health * max_health
