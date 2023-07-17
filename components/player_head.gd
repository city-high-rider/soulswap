extends Camera3D
class_name PlayerHead

## This class is the player's "head". It's stuff that the player should always have, regardless
## of which body they are controlling. For example, a camera and a raycast to tell where they are aiming.
## Player UI is part of the ghost, however.

## What is the ghost mount? We send requests to change the ghost there.
@export var ghost_mount : GhostMount

@onready var possess_ray : RayCast3D = $PossessRay

var possess_cooldown : float = 0

func _ready() -> void:
	if ghost_mount.ghost is PlayerGhost:
		make_current()
	ghost_mount.ghost_emitted_output.connect(_on_ghost_emitted_output)
	ghost_mount.ghost_changed.connect(_on_ghost_mount_ghost_changed)

func _physics_process(delta: float) -> void:
	possess_cooldown = max(0, possess_cooldown - delta)
	
func _on_ghost_emitted_output(action: String, payload) -> void:
	match action:
		"possess":
			if possess_ray.get_collider() is Shell and possess_cooldown == 0:
				var new_host : Shell = possess_ray.get_collider()
				print_debug("ghost " + str(ghost_mount.ghost) + " in body " + str(ghost_mount.shell) + " possessed " + str(new_host) + " which had ghost " + str(new_host.ghost_mount.ghost))
				new_host.change_ghost(ghost_mount.ghost)
				new_host.head.possess_cooldown = 1
				possess_cooldown = 1
				ghost_mount.clear_ghost()

func _on_ghost_mount_ghost_changed(new_ghost, is_player):
	if is_player:
		make_current()
