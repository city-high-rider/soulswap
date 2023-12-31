extends Node3D
## This is a spawner that basically instantiates another scene.
class_name EnemySpawner

## Which thing should we spawn in? This should be a shell.
@export var enemy : PackedScene

# Has the spawner been used already?
var is_used : bool = false

var saved_state : bool = false

# Reference to the spawned enemy.
var spawned_entity : Shell

signal enemy_died

func _ready() -> void:
	CheckpointManager.checkpoint_activated.connect(save_state)
	CheckpointManager.load_checkpoint.connect(load_state)

func spawn() -> void:
	if is_used:
		return
	spawned_entity = enemy.instantiate()
	spawned_entity.died.connect(on_enemy_died)
	spawned_entity.ghost_mount.ghost_changed.connect(_on_spawned_entity_ghost_changed)
	add_child(spawned_entity)
	is_used = true

func save_state() -> void:
	saved_state = is_used

func load_state() -> void:
	is_used = saved_state
	if !is_used and spawned_entity:
		spawned_entity.died.disconnect(on_enemy_died)
		spawned_entity.queue_free()
		spawned_entity = null

func on_enemy_died() -> void:
	spawned_entity = null
	enemy_died.emit()

func _on_spawned_entity_ghost_changed(_new_ghost, is_player: bool):
	if is_player:
		enemy_died.emit()
		
