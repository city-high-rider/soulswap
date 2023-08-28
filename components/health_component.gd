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

var saved_health : HealthComponentSave = HealthComponentSave.new()

# Here are some signals for connecting to bodies and other stuff

## Emitted when health is changed. Source is what caused the max health to change. 
## This is usually a reference to an attacker.
signal health_changed(new_health: int)

## Emitted when max health is changed.
signal max_health_changed(new_max_health: int)

## Emitted when health reaches zero.
signal died


func _ready() -> void:
	CheckpointManager.checkpoint_activated.connect(save_health)
	CheckpointManager.load_checkpoint.connect(load_health)
	current_health = max_health
	save_health()

# function that takes a raw number to subtract from the health. Hitbox is responsible for
# calculating this given damage types / resistances etc.
# We return whether the damage was lethal (took us below 0hp) or not.
func take_damage(damage: int) -> bool:
	var is_already_dead : bool = current_health <= 0
	var is_damage_lethal : bool = false
	
	current_health = clamp(current_health - damage, 0, max_health)
	if current_health <= 0 and !is_already_dead:
		emit_signal("died")
		is_damage_lethal = true
	else:
		emit_signal("health_changed", current_health)
	return is_damage_lethal


func save_health() -> void:
	saved_health.saved_health = current_health
	saved_health.saved_max_health = max_health
	
func load_health() -> void:
	max_health = saved_health.saved_max_health
	current_health = saved_health.saved_health
