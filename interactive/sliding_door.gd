extends Node3D
## This is a simple animated sliding door.


## Reference to the animation player
@onready var animation_player : AnimationPlayer = $AnimationPlayer

## Is this door initially open or closed?
@export var initially_open : bool = false
var is_open : bool = initially_open

func _ready() -> void:
	if initially_open:
		open()
	else:
		close()
		
func open() -> void:
	if is_open:
		return
	is_open = true
	animation_player.play("open")
	
func close() -> void:
	if !is_open:
		return
	is_open = false
	animation_player.play("close")
	


func _on_encounter_all_enemies_killed():
	open()


func _on_area_3d_body_entered(body):
	if body == PlayerInfo.current_player_shell:
		close()
