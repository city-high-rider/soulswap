extends CharacterBody3D

@export var speed : float = 10
@export var explosion : PackedScene

@onready var raycast : RayCast3D = $RayCast3D
func _physics_process(delta: float) -> void:
	velocity = -global_transform.basis.z * speed
	move_and_slide()
	
	if raycast.is_colliding():
		if explosion:
			var new_explosion = explosion.instantiate()
			get_node("/root").add_child(new_explosion)
			new_explosion.global_transform.origin = global_transform.origin
		queue_free()
