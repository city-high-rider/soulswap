extends Control
class_name PlayerUI

# This ui is for the player body.

# Which margin container has the body info?
@export var body_info : MarginContainer

# The text field for pop-ups
@onready var popup_text : TextBox = $TextBox

var is_body_info_showing : bool = true

func toggle_body_info() -> void:
	if is_body_info_showing:
		body_info.hide()
	else:
		body_info.show()
	is_body_info_showing = !is_body_info_showing

