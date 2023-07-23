extends Node3D
# This is the rocket launcher gun.

## Which rocket are we firing?
@export var rocket : PackedScene

## Where is the hitscan manager? 
@export var hitscan_manager : HitscanManager

## Which ghost mount are we getting inputs from?
@export var ghost_mount : GhostMount


func fire() -> void:
	var look_point = hitscan_manager.get_look_point()
	var destination : Vector3 = look_point if look_point else to_global(transform.origin + Vector3.FORWARD)
	
	var new_rocket = rocket.instantiate()
	add_child(new_rocket)
	new_rocket.look_at(destination)


func _physics_process(delta: float) -> void:
	if ghost_mount.get_ghost_inputs().primary_depressed:
		fire()
