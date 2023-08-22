extends Area3D
## This is a hitbox for anything that needs to receive damage from an in-game source.
## it can connect to a health component.
class_name Hitbox

## Which health component are we connecting to?
@export var health_component : HealthComponent

## By how much should we multiply *all* incoming damage? useful for weak points, like a 
## headshot hitbox.
@export var damage_multiplier : float = 1

## We are responsible for relaying information about the attack's origin.
## Signal when we take damage from a distinct source
signal took_damage(lethal: bool, damage: Damage, attacker)

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


func _ready() -> void:
	body_entered.connect(_on_body_entered)

# function that is called when we take damgae
# damage is the damage object, attacker is usually the shell that attacked us
func take_damage(damage : Damage, attacker) -> void:
	# Calculate the damage multiplier given our damage resistances defaulting to 1.
	var specific_type_multiplier : float = 1
	match damage.damage_type:
		damage.DamageType.Kinetic:
			specific_type_multiplier = kinetic_mult
		damage.DamageType.Explosive:
			specific_type_multiplier = explosive_mult
		damage.DamageType.Plasma:
			specific_type_multiplier = plasma_mult
			
	if health_component:
		var was_damage_lethal : bool = health_component.take_damage(damage.damage_amount * damage_multiplier * specific_type_multiplier)
		took_damage.emit(was_damage_lethal, damage, attacker)

# We use this to detect collision with projectiles.
func _on_body_entered(body) -> void:
	print_debug("entered")
	print_debug(body)
	if body is Projectile:
		print_debug("projectile entered")
		take_damage(body.damage, null)
		body.on_hitbox_collide.call()
