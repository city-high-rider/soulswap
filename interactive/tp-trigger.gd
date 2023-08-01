extends Node3D
## This is a trigger volume that teleports the player back somewhere when they fall into it.
## useful for platforming sections.

## Area to use for collision.
@export var trigger_area : Area3D
## Place to teleport the player
@export var tp_destination : Marker3D

func _ready() -> void:
	if trigger_area and !trigger_area.body_entered.is_connected(_on_enter_trigger):
		trigger_area.body_entered.connect(_on_enter_trigger)
	

func _on_enter_trigger(body) -> void:
	if body is Shell and body == PlayerInfo.current_player_shell and tp_destination:
		body.global_transform.origin = tp_destination.global_transform.origin
