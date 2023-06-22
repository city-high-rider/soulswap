extends CollisionShape3D
class_name Hitbox

# This is a hitbox for anything that needs to receive damage from an in-game source.
# it can connect to a health component.

# Which health component are we connecting to?
@export var health_component : HealthComponent

# By how much should we multiply incoming damage? useful for weak points, like a 
# headshot hitbox.
@export var damage_multiplier : float = 1

# function that is called when we take damgae.
func damage(amount: float) -> void:
	if health_component:
		health_component.damage(amount * damage_multiplier)
