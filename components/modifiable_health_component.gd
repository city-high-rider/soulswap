extends HealthComponent
## This is a health component that uses the ghost possession modifiers.

## Which ghost mount are we reading from?
@export var ghost_mount : GhostMount

func _ready() -> void:
	recalibrate_max_health()
	super()
	ghost_mount.ghost_changed.connect(recalibrate_max_health)
	
func recalibrate_max_health() -> void:
	max_health *= ghost_mount.get_ghost_modifiers().max_health_multiplier
