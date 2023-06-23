extends Ghost

# This is a ghost which is controlled by the player.

func _input(event: InputEvent) -> void:
	var input_direction: Vector2 = Input.get_vector("ui_left", "ui_right", "ui_down", "ui_up")
	emit_signal("emitted_output", input_direction)
