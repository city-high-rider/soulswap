extends CharacterBody3D

@export var speed : float = 10
@export var explosion : PackedScene

var despawn_time : float = 10

@onready var detonate_area : Area3D = $Area3D

func _ready() -> void:
	get_tree().create_timer(despawn_time).timeout.connect(queue_free)
	
	
func _physics_process(delta: float) -> void:
	velocity = -global_transform.basis.z * speed
	move_and_slide()
	


func _on_area_3d_body_entered(body):
	if explosion:
		var new_explosion = explosion.instantiate()
		get_node("/root").add_child(new_explosion)
		new_explosion.global_transform.origin = global_transform.origin
	queue_free()
