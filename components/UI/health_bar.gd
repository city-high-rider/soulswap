@tool
extends HBoxContainer
class_name HealthBar

# This class is for a health bar UI component. 
# Link to the actual bar child.
@onready var bar : ProgressBar = $ProgressBar

@onready var label : Label = $Label

# Which health component are we tracking?
@export var health : HealthComponent

# What should the text next to the bar say?
@export var text : String = "Health"

func _ready() -> void:
	calibrate()
	health.health_changed.connect(_on_health_changed)
	label.text = text

# Set the bar's max value and value to match the component.
func calibrate() -> void:
	bar.max_value = health.max_health
	bar.value = health.current_health
	
	
func _on_health_changed(new_health) -> void:
	bar.value = new_health
