extends Node
class_name HealthComponent

# This class is for anything that needs to keep track of some health. 

# what's the maximum amount of health this component can have?
@export var max_health : int = 100:
	set(value):
		# make sure that we emit signals if we change the max health
		max_health = value
		emit_signal("max_health_changed", value)
	get:
		return max_health

# how much health do we currently have?
var current_health : int = max_health:
	set(value):
		# again, make sure that the signals are emitted if we change health
		current_health = value
		emit_signal("health_changed", value) 
	get:
		return current_health


# Here are some signals for connecting to bodies and other stuff
signal health_changed(new_health: int)
signal max_health_changed(new_max_health: int)
signal died

# method for taking damage
func take_damage(damage: int) -> void:
	current_health = max(0, current_health - damage)
	if current_health <= 0:
		emit_signal("died")
	else:
		emit_signal("health_changed", current_health)
