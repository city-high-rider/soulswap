extends Area3D
class_name PopupArea

# This class is an area that will show text when you walk through it.

# what text message do we want to show?
@export_multiline var message : String = ""

func _on_body_entered(body):
	if body is Shell:
		body.UI.popup_text.set_text(message)
