extends Node3D
## This is a spawner that basically instantiates another scene.
class_name EnemySpawner

## Which thing should we spawn in?
@export var enemy : PackedScene

# Has the spawner been used already?
var is_used : bool = false

var saved_state : bool = false

# Reference to the spawned enemy.
var spawned_entity : Node

func _ready() -> void:
	CheckpointManager.checkpoint_activated.connect(save_state)
	CheckpointManager.load_checkpoint.connect(load_state)

func spawn() -> void:
	if spawned_entity:
		spawned_entity.queue_free()
	spawned_entity = enemy.instantiate()
	add_child(spawned_entity)

func save_state() -> void:
	saved_state = is_used

func load_state() -> void:
	is_used = saved_state
	if !is_used:
		spawned_entity.queue_free()
