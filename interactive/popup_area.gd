extends Area3D
class_name PopupArea

# This class is an area that will show text when you walk through it.

# what text message do we want to show?
@export_multiline var message : String = ""

func _on_body_entered(body):
	if body is Shell and "popup" in body.ghost_mount.ghost:
		body.ghost_mount.ghost.popup.show_text(message)
