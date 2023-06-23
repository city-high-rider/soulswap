extends Ghost

# This is a ghost which is controlled by the player.
func _ready() -> void:
	# capture the mouse in the middle of the screen
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	
func _input(event: InputEvent) -> void:
	var input_direction: Vector2 = Input.get_vector("left", "right", "back", "forward")
	emit_signal("emitted_output", "moving", input_direction)
	if event is InputEventMouseMotion:
		emit_signal("emitted_output", "looking", Vector2(event.relative.x, event.relative.y))
