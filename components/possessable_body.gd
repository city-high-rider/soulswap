extends CharacterBody3D
class_name Shell

# this class is any character body that can be possessed by a player or an AI. The 
# entity controlling the "shell" is referred to as the "ghost".

# What's the main health component? If its health drops to zero, the body dies.
@export var health : HealthComponent

# What is the player head? This will contain the camera and a raycast node.
@export var head : PlayerHead

# Where is our ghost located?
@export var ghost_mount : GhostMount

# We cal this signal when the body has been possessed by a player ghost. That way UI elements can show themselves etc.
signal player_possessed

# If only we had ADTs like in Haskell or Elm...
func _on_ghost_emitted_output(action: String, payload) -> void:
	match action:
		"possess":
			if head.possess_ray.get_collider() is Shell:
				var new_host : Shell = head.possess_ray.get_collider()
				set_physics_process(false)
				new_host.call_deferred("change_ghost", ghost_mount.ghost)
				queue_free()
			

func _physics_process(delta: float) -> void:
	# Look around using the ghost's mouse direction.
	rotate_y(-ghost_mount.ghost.mouse_direction.x)
	head.rotate_x(-ghost_mount.ghost.mouse_direction.y)
	head.rotation.x = clamp(head.rotation.x, deg_to_rad(-89), deg_to_rad(89))

func change_ghost(new_ghost: Ghost) -> void:
	ghost_mount.change_ghost(new_ghost)


func _on_ghost_mount_ghost_changed(new_ghost, is_player):
	new_ghost.emitted_output.connect(_on_ghost_emitted_output)
