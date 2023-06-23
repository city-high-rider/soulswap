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


func _ready() -> void:
	ghost.emitted_output.connect(_on_ghost_emitted_output)


# If only we had ADTs like in Haskell or Elm...
func _on_ghost_emitted_output(action: String, payload) -> void:
	match action:
		"moving":
			velocity = transform.basis * Vector3(payload.x, 0, -payload.y)
		"looking":
			rotate_y(deg_to_rad(-payload.x))
			camera.rotate_x(deg_to_rad(-payload.y))
			camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-89), deg_to_rad(89))
	
	
func _physics_process(_delta: float) -> void:
	move_and_slide()
