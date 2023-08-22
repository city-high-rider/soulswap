extends Projectile

@export var explosion : PackedScene
@onready var booster_sound : AudioStreamPlayer3D = $AudioStreamPlayer3D


# Set the rocket to explode on collision
func _init() -> void:
	on_collide = explode
	on_hitbox_collide = explode

# Spawn an explosion if we have one and delete ourselves
func explode() -> void:
	if explosion:
		var new_explosion = explosion.instantiate()
		get_node("/root").add_child(new_explosion)
		new_explosion.global_transform.origin = global_transform.origin
		new_explosion.thrower = thrower
	queue_free()
	
# Make sure the sound loops
func _on_audio_stream_player_3d_finished():
	booster_sound.play()
