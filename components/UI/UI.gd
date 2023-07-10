extends Control
class_name PlayerUI

# This ui is for the player body.

# Which margin container has the body info?
@export var body_info : MarginContainer

# Ghost mount point, so that we can detect when we are possessed by a player.
@export var ghost_mount : GhostMount

func _ready() -> void:
	hide()
	ghost_mount.ghost_changed.connect(on_possess)

var is_body_info_showing : bool = false

func toggle_body_info() -> void:
	if is_body_info_showing:
		body_info.hide()
	else:
		body_info.show()
	is_body_info_showing = !is_body_info_showing


func on_possess(_new_ghost: Ghost, is_player: bool) -> void:
	if !is_player:
		return
	show()
	toggle_body_info()
	await get_tree().create_timer(2).timeout
	toggle_body_info()
