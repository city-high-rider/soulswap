extends Node3D

@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var blast_radius : Area3D = $BlastRadius

## How far should we launch stuff that gets caught in the explosion?
@export var knockback : float = 6.5
func _ready() -> void:
	animation_player.play("explode")
	await animation_player.animation_finished
	queue_free()


func _on_blast_radius_area_entered(area):
	if area is Hitbox:
		area.take_damage(10, null)


func _on_blast_radius_body_entered(body):
	if body is CharacterBody3D:
		body.velocity += (body.global_transform.origin - global_transform.origin) * knockback
