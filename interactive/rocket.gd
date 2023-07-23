extends CharacterBody3D

func _physics_process(delta: float) -> void:
	velocity = to_global(Vector3.FORWARD)
	move_and_slide()
