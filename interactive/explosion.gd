extends Node3D

@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var blast_radius : Area3D = $BlastRadius

@onready var explosion_sound : AudioStreamPlayer3D = $AudioStreamPlayer3D
## How far should we launch stuff that gets caught in the explosion?
@export var knockback : float = 8
func _ready() -> void:
	animation_player.play("explode")
	explosion_sound.play()
	await animation_player.animation_finished
	queue_free()


func _on_blast_radius_area_entered(area):
	if area is Hitbox:
		area.take_damage(10, null)


func _on_blast_radius_body_entered(body):
	if body is CharacterBody3D:
		# vector3.up is added so that it's more likely the explosion will launch us UP
		body.velocity += (body.global_transform.origin - global_transform.origin + Vector3.UP * .3) * knockback
