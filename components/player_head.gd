extends Camera3D
class_name PlayerHead

## This class is the player's "head". It's stuff that the player should always have, regardless
## of which body they are controlling. For example, a camera and a raycast to tell where they are aiming.
## Player UI is part of the ghost, however.

## What is the ghost mount? We send requests to change the ghost there.
@export var ghost_mount : GhostMount

@onready var possess_ray : RayCast3D = $PossessRay

func _ready() -> void:
	if ghost_mount.ghost is PlayerGhost:
		make_current()
	ghost_mount.ghost_emitted_output.connect(_on_ghost_emitted_output)

func _on_ghost_emitted_output(action: String, payload) -> void:
	match action:
		"possess":
			if possess_ray.get_collider() is Shell:
				var new_host : Shell = possess_ray.get_collider()
				new_host.call_deferred("change_ghost", ghost_mount.ghost)
				ghost_mount.shell.queue_free()

func _on_ghost_mount_ghost_changed(new_ghost, is_player):
	if is_player:
		make_current()
