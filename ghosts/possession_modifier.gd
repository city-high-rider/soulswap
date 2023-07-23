extends Resource
## Resource that describes how we should modify the host that we are possessing. This incliudes
## things like extra speed, health, etc.
class_name PossessionModifier

## What should we multiply our max health by?
@export var max_health_multiplier : float = 1

## What should we multiply our base damage by?
@export var base_damage_multiplier : float = 1
