extends EnemySpawner
## This is a spawner that is triggered by an Area3D.

## Which area3D triggers this spawner?
@export var trigger_area : Area3D

func _ready():
	if trigger_area:
		trigger_area.body_entered.connect(_on_area_body_entered)
	

func _on_area_body_entered(body):
	if body is Shell:
		spawn()
