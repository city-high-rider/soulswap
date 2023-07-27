extends Node3D
## This is a node that can spawn multiple enemies and emits a signal when it is done.
## This is usually used for combat encounters.


## Emit this when all the enemies we can spawn are killed.
signal all_enemies_killed

## The spawners should be a child of this node.
var spawners : Array[Node] = []

var amt_enemies_killed : int = 0
var enemies_killed_save : int = 0

func _ready() -> void:
	spawners = get_children().filter(func(c): return c is EnemySpawner)
	for s in spawners:
		s.enemy_died.connect(on_spawner_enemy_killed)
	CheckpointManager.checkpoint_activated.connect(save_data)
	CheckpointManager.checkpoint_activated.connect(load_data)
		
func on_spawner_enemy_killed():
	amt_enemies_killed += 1
	if amt_enemies_killed == len(spawners):
		all_enemies_killed.emit()

func save_data() -> void:
	enemies_killed_save = amt_enemies_killed
	
func load_data() -> void:
	amt_enemies_killed = enemies_killed_save

func start() -> void:
	for s in spawners:
		s.spawn()
		
func _on_area_3d_body_entered(body):
	start()
