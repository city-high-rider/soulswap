extends CharacterBody3D

@export var speed : float = 27
@export var explosion : PackedScene

var despawn_time : float = 10

@onready var detonate_area : Area3D = $Area3D
@onready var booster_sound : AudioStreamPlayer3D = $AudioStreamPlayer3D

func _ready() -> void:
	get_tree().create_timer(despawn_time).timeout.connect(queue_free)
	
	
func _physics_process(delta: float) -> void:
	velocity = -global_transform.basis.z * speed
	# Move and slide returns true if we collide with something.
	if move_and_slide():
		explode()

# Spawn an explosion if we have one and delete ourselves
func explode() -> void:
	if explosion:
		var new_explosion = explosion.instantiate()
		get_node("/root").add_child(new_explosion)
		new_explosion.global_transform.origin = global_transform.origin
	queue_free()
	
# Make sure the sound loops
func _on_audio_stream_player_3d_finished():
	booster_sound.play()
