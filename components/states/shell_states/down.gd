extends ShellState
## This is the default "death" state. You basically are just frozen in place.

func handle_physics(_delta: float) -> void:
	if !user.is_on_floor():	
		user.velocity.y += -4.0
	user.move_and_slide()
