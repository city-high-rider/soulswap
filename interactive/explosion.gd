extends Node3D

@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var blast_radius : Area3D = $BlastRadius

func _ready() -> void:
	animation_player.play("explode")
	await animation_player.animation_finished
	queue_free()


func _on_blast_radius_area_entered(area):
	if area is Hitbox:
		area.take_damage(10, null)
