extends Resource
## This resource tracks damage related properties so we can compute resistances, etc.
class_name Damage

# Define types of damage.
enum DamageType {Kinetic, Explosive, Plasma}

## Which type of damage are we dealing?
@export var damage_type : DamageType = DamageType.Kinetic

## How much damage points do we deal?
@export var damage_amount : float = 10
