extends MarginContainer
class_name TextBox

# This is a cool looking text box that can be used in UI.

# Reference to the label
@onready var label : Label = $Label

func set_text(new_text: String) -> void:
	label.text = new_text
