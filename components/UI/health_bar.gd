extends HBoxContainer
class_name HealthBar

# This class is for a health bar UI component. 
# Link to the actual bar child.
@onready var bar : ProgressBar = $ProgressBar

# Which health component are we tracking?
@export var health : HealthComponent

func _ready() -> void:
	calibrate()

# Set the bar's max value and value to match the component.
func calibrate() -> void:
	bar.max_value = health.max_health
	bar.value = health.current_health
	
