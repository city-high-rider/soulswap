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


func _ready() -> void:
	ghost.emitted_output.connect(_on_ghost_emitted_output)


func _on_ghost_emitted_output(output: Vector2) -> void:
	velocity = transform.basis * Vector3(output.x, 0, -output.y)
	
func _physics_process(_delta: float) -> void:
	move_and_slide()
