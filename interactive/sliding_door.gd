extends Node3D
## This is a simple animated sliding door.


## Reference to the animation player
@onready var animation_player : AnimationPlayer = $AnimationPlayer

## Is this door initially open or closed?
@export var initially_open : bool = false
var is_open : bool = initially_open
var saved_state : bool = initially_open

func _ready() -> void:
	if initially_open:
		open()
	else:
		close()
	CheckpointManager.checkpoint_activated.connect(save_data)
	CheckpointManager.load_checkpoint.connect(load_data)
		
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

func _on_encounter_encounter_started():
	close()
	
func save_data() -> void:
	saved_state = is_open

func load_data() -> void:
	var old_state_is_open = is_open
	if !old_state_is_open and saved_state:
		open()
	elif old_state_is_open and !saved_state:
		close()
	is_open = saved_state

