extends CharacterBody3D

func _physics_process(delta: float) -> void:
	velocity = -global_transform.basis.z * 5
	move_and_slide()
