extends Node3D
## This is a spawner that is triggered by an Area3D.

# reference to the spawner
@onready var spawner : EnemySpawner = $EnemySpawner

func _on_area_3d_body_entered(body):
	if body == PlayerInfo.current_player_shell:
		spawner.spawn()
