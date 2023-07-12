extends Control

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("restart") and is_visible_in_tree():
		CheckpointManager.load_checkpoint.emit()
		hide()
