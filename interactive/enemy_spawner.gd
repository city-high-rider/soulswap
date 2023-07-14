extends Node3D
## This is a spawner that basically instantiates another scene.
class_name EnemySpawner

## Which thing should we spawn in?
@export var enemy : PackedScene

# Has the spawner been used already?
var is_used : bool = false

var saved_state : bool = false

func _ready() -> void:
	CheckpointManager.checkpoint_activated.connect(save_state)
	CheckpointManager.load_checkpoint.connect(load_state)


func save_state() -> void:
	saved_state = is_used
	

func load_state() -> void:
	is_used = saved_state
