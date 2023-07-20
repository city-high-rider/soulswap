extends Node
## This class is for anything that needs to keep track of some health. 
class_name HealthComponent


## what's the maximum amount of health this component can have?
@export var max_health : int = 100:
	set(value):
		# make sure that we emit signals if we change the max health
		max_health = max(1, value)
		emit_signal("max_health_changed", value)

# how much health do we currently have?
var current_health : int = max_health:
	set(value):
		# again, make sure that the signals are emitted if we change health
		current_health = clamp(value, 0, max_health)
		emit_signal("health_changed", current_health)
		if current_health <= 0:
			died.emit()

var saved_health : HealthComponentSave = HealthComponentSave.new()

# Here are some signals for connecting to bodies and other stuff

## Emitted when health is changed. Source is what caused the max health to change. 
## This is usually a reference to an attacker.
signal health_changed(new_health: int)

## Emitted when max health is changed.
signal max_health_changed(new_max_health: int)

## Emitted when health reaches zero.
signal died(cause)

## Emitted when we take damage from a specified source. Similar to health_changed, but
## carries additional information
signal took_damage(new_health: int, source)


func _ready() -> void:
	CheckpointManager.checkpoint_activated.connect(save_health)
	CheckpointManager.load_checkpoint.connect(load_health)
	current_health = max_health
	save_health()


func take_damage(damage: int, source) -> void:
	current_health = clamp(current_health - damage, 0, max_health)
	if current_health <= 0:
		emit_signal("died")
	else:
		emit_signal("health_changed", current_health)
		took_damage.emit(current_health, source)


func save_health() -> void:
	saved_health.saved_health = current_health
	saved_health.saved_max_health = max_health
	
func load_health() -> void:
	max_health = saved_health.saved_max_health
	current_health = saved_health.saved_health
