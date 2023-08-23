extends CharacterBody3D

## this class is any character body that can be possessed by a player or an AI. The 
## entity controlling the "shell" is referred to as the "ghost".
class_name Shell

## What is the player head? This will contain the camera and a raycast node.
@export var head : PlayerHead

## Where is our ghost located?
@export var ghost_mount : GhostMount

## How hard is this body to possess?
@export var possess_cost : float = 10

## Reference to buff manager. We don't use this, but other entites might need to
@export var buff_manager : BuffManager

## Current saved data 
var current_save : ShellCheckpointSave = ShellCheckpointSave.new()

signal died

func _ready() -> void:
	CheckpointManager.checkpoint_activated.connect(save_data)
	CheckpointManager.load_checkpoint.connect(load_data)
	save_data()


func _physics_process(_delta: float) -> void:
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
	show()

# This is used by spawners to check if the shell has died.
func _on_health_component_died():
	hide()
	if !self == PlayerInfo.last_saved_player_shell and !self == PlayerInfo.current_player_shell:
		queue_free()
	died.emit()
	
	
func _on_hitbox_took_damage(_lethal, damage, attacker, is_direct: bool):
	# Detect friedly fire and award style points.
	if attacker is Shell and self != PlayerInfo.current_player_shell and attacker != PlayerInfo.current_player_shell:
		PlayerInfo.current_player_shell.ghost_mount.ghost.award_style(0.5 * damage.damage_amount, "+ FRIENDLY FIRE")
		
	# Detect direct hits and award style.
	if is_direct and attacker != self and attacker is Shell and attacker.ghost_mount.ghost.has_method("award_style"):
		attacker.ghost_mount.ghost.award_style(10 * damage.damage_amount, "+ DIRECT HIT")
		# Furthermore, if we are in the air, give a further bonus.
		if !is_on_floor():
			attacker.ghost_mount.ghost.award_style(50, "+ AEIRAL HIT")
