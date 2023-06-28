extends CharacterBody3D
class_name Shell

# this class is any character body that can be possessed by a player or an AI. The 
# entity controlling the "shell" is referred to as the "ghost".

# What's the main health component? If its health drops to zero, the body dies.
@export var health : HealthComponent

# What camera are we looking out of?
@export var camera : Camera3D

# Which ghost is controlling us?
@export var ghost : Ghost

# Which state machine is this body using? It will govern how our body moves, falls, etc.
@export var state_machine : StateMachine

# What's the UI node? We hide this when the body is not being used by a player.
@export var UI : Control

# ray to hit possessable bodies from. Being used for testing.
@onready var ray : RayCast3D = camera.get_node("RayCast3D")


func _ready() -> void:
	ghost.emitted_output.connect(_on_ghost_emitted_output)
	state_machine.init(self)
	if ghost is PlayerGhost:
		UI.show()
	else:
		UI.hide()

# If only we had ADTs like in Haskell or Elm...
func _on_ghost_emitted_output(action: String, payload) -> void:
	state_machine.handle_ghost_output(action, payload)
	match action:
		"possess":
			if ray.get_collider() is Shell:
				var new_host : Shell = ray.get_collider()
				new_host.change_ghost(ghost)
				queue_free()
		"toggle_info":
			UI.toggle_body_info()

func _physics_process(delta: float) -> void:
	state_machine.handle_physics(delta)
	# Look around using the ghost's mouse direction.
	rotate_y(deg_to_rad(-ghost.mouse_direction.x))
	camera.rotate_x(deg_to_rad(-ghost.mouse_direction.y))
	camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-89), deg_to_rad(89))


func change_ghost(new_ghost: Ghost) -> void:
	# first, get rid of the current ghost.
	if ghost:
		ghost.emitted_output.disconnect(_on_ghost_emitted_output)
		remove_child(ghost)
		ghost.queue_free()
	
	# then, attach the new one.
	ghost = new_ghost
	ghost.emitted_output.connect(_on_ghost_emitted_output)
	ghost.get_parent().remove_child(ghost)
	add_child(ghost)
	
	# Show or hide the UI
	if ghost is PlayerGhost:
		UI.show()
	else:
		UI.hide()
	
	# Set our camera as the current one.
	camera.make_current()
	
	print_tree_pretty()
	print_debug(ghost)
