extends Area3D
## This is a hitbox for anything that needs to receive damage from an in-game source.
## it can connect to a health component.
class_name Hitbox

## Which health component are we connecting to?
@export var health_component : HealthComponent

## By how much should we multiply all incoming damage? useful for weak points, like a 
## headshot hitbox.
@export var damage_multiplier : float = 1

# Note that right now we have separate exports for each damage type.. if this grows we should change
# to something like an array of tuples. I didn't do that right now because godot doesn't have built in tuples.

## Do we have resistances or weaknesses to any damage types? Specify the damage multiplier
@export_group("Damage resistances")
## Multiply incoming kinetic damage by this
@export var kinetic_mult : float = 1
## Multiply incoming explosive damage by this
@export var explosive_mult : float = 1
## Multiply incoming plasma damage by this
@export var plasma_mult : float = 1


# function that is called when we take damgae.
func take_damage(damage : Damage, source) -> void:
	var specific_type_multiplier : float = 1
	match damage.damage_type:
		damage.DamageType.Kinetic:
			kinetic_mult
		damage.DamageType.Explosive:
			explosive_mult
		damage.DamageType.Plasma:
			plasma_mult
			
	if health_component:
		health_component.take_damage(damage.damage_amount * damage_multiplier * specific_type_multiplier, source)
