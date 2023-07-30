extends CharacterBody3D
class_name Shell

## this class is any character body that can be possessed by a player or an AI. The 
## entity controlling the "shell" is referred to as the "ghost".

## What is the player head? This will contain the camera and a raycast node.
@export var head : PlayerHead

## Where is our ghost located?
@export var ghost_mount : GhostMount

## How hard is this body to possess?
@export var possess_cost : float = 10

## Current saved data 
var current_save : ShellCheckpointSave = ShellCheckpointSave.new()

signal died

func _ready() -> void:
	CheckpointManager.checkpoint_activated.connect(save_data)
	CheckpointManager.load_checkpoint.connect(load_data)
	save_data()


func _physics_process(delta: float) -> void:
	# Look around using the ghost's mouse direction.
	var mouse_direction : Vector2 = ghost_mount.get_ghost_inputs().mouse_direction
	rotate_y(-mouse_direction.x)
	head.rotate_x(-mouse_direction.y)
	head.rotation.x = clamp(head.rotation.x, deg_to_rad(-89), deg_to_rad(89))

func change_ghost(new_ghost: Ghost) -> void:
	ghost_mount.change_ghost(new_ghost)

func save_data() -> void:
	current_save.saved_global_transform = global_transform

func load_data() -> void:
	global_transform = current_save.saved_global_transform

# This is used by spawners to check if the shell has died.
func _on_health_component_died():
	hide()
	if !self == PlayerInfo.last_saved_player_shell and !self == PlayerInfo.current_player_shell:
		queue_free()
	died.emit()
