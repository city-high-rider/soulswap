extends CharacterBody3D
class_name Shell

# this class is any character body that can be possessed by a player or an AI. The 
# entity controlling the "shell" is referred to as the "ghost".

# What's the main health component? If its health drops to zero, the body dies.
@export var health : HealthComponent

# What is the player head? This will contain the camera and a raycast node.
@export var head : PlayerHead

# Which ghost is controlling us?
@export var ghost : Ghost

# Which state machine is this body using? It will govern how our body moves, falls, etc.
@export var state_machine : StateMachine

# We cal this signal when the body has been possessed by a player ghost. That way UI elements can show themselves etc.
signal player_possessed

func _ready() -> void:
	change_ghost(ghost)

# If only we had ADTs like in Haskell or Elm...
func _on_ghost_emitted_output(action: String, payload) -> void:
	state_machine.handle_ghost_output(action, payload)
	match action:
		"possess":
			if head.possess_ray.get_collider() is Shell:
				var new_host : Shell = head.possess_ray.get_collider()
				PlayerInfo.current_player_shell = new_host
#				set_physics_process(false)
				new_host.call_deferred("change_ghost", ghost)
#				queue_free()
			

func _physics_process(delta: float) -> void:
	state_machine.handle_physics(delta)
	# Look around using the ghost's mouse direction.
	rotate_y(-ghost.mouse_direction.x)
	head.rotate_x(-ghost.mouse_direction.y)
	head.rotation.x = clamp(head.rotation.x, deg_to_rad(-89), deg_to_rad(89))


func change_ghost(new_ghost: Ghost) -> void:
	# first, get rid of the current ghost.
	if ghost != new_ghost:
		remove_child(ghost)
		ghost.queue_free()
	
	# then, attach the new one.
	new_ghost.reparent(self, false)
	ghost = new_ghost
	if !ghost.emitted_output.is_connected(_on_ghost_emitted_output):
		ghost.emitted_output.connect(_on_ghost_emitted_output)
	# Re-inisitalise the state machine so that the ghost is updated.
	state_machine.init(self)
	
	# Show or hide the UI
	if ghost is PlayerGhost:
		PlayerInfo.current_player_shell = self
		emit_signal("player_possessed")
		# Set our camera as the current one.
		head.make_current()
