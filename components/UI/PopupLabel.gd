extends MarginContainer
## This is a popup label that can display some text.

## Reference to the text label
@onready var label : Label = $Label

## How long until we hide the popup?
var time_until_hide : float = 0

func _ready() -> void:
	hide()

func _physics_process(delta: float) -> void:
	time_until_hide = max(0, time_until_hide - delta)
	if time_until_hide <= 0:
		hide()
		
func show_text(text: String) -> void:
	show()
	label.set_text(text)
	time_until_hide = 4
	
	
