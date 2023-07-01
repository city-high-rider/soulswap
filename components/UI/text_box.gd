extends MarginContainer
class_name TextBox

# This is a cool looking text box that can be used in UI.

# Reference to the label
@onready var label : Label = $Label

# How long is the text shown for?
@onready var display_time : float = 6

func _ready() -> void:
	hide()

func set_text(new_text: String) -> void:
	show()
	label.text = new_text
	fade_after(display_time)
	
func fade_after(time_seconds: float) -> void:
	await get_tree().create_timer(time_seconds).timeout
	hide()
