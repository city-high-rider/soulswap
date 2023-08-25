extends Area3D
## This class is an area that will show text when you walk through it.
class_name PopupArea


## what text message do we want to show?
@export_multiline var message : String = ""

# Reference to audio player
@onready var ping : AudioStreamPlayer3D = $ping

# Have we already played the ping noise?
var has_been_activated_previously : bool = false

func _ready() -> void:
	has_been_activated_previously = false

func _on_body_entered(body):
	if body is Shell and body.ghost_mount.ghost and "popup" in body.ghost_mount.ghost:
		body.ghost_mount.ghost.popup.show_text(message)
		# Make sure we don't play the ping if we walk into the same popup again, but do show the text.
		if !has_been_activated_previously:
			ping.play()
			has_been_activated_previously = true
