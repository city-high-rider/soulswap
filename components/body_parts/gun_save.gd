extends Resource
## This contains information a "gun" might want to save when a checkpoint is reached.
class_name GunSave

## Is the gun broken?
@export var is_broken : bool = false

## How much ammo is left?
@export var saved_ammo : float = 0
