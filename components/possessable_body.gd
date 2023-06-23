extends CharacterBody3D
class_name PossessableBody

# this class is any character body that can be possessed by the player. While this is
# pretty flexible, there are a few things that we need to have.

# Which camera should we look out of?
@export var body_camera : Camera3D

# Which state machine should the player control?
@export var player_state_machine : StateMachine

# What's the main health component? If its health drops to zero, the body dies.
@export var main_health : HealthComponent

# What's the mouse sensitivity?
var mouse_sens : float = 0.1

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
# We probably want everything to have the ability to look around.
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * mouse_sens))
		body_camera.rotate_x(deg_to_rad(-event.relative.y * mouse_sens))
		# Clamp the camera's rotation so that we can't look over 90 degrees up.
		body_camera.rotation.x = clamp(body_camera.rotation.x, deg_to_rad(-89), deg_to_rad(80))
