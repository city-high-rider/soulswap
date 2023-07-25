extends Node3D
# This is the rocket launcher gun.

## Which rocket are we firing?
@export var rocket : PackedScene

## Where is the hitscan manager? 
@export var hitscan_manager : HitscanManager

## Which ghost mount are we getting inputs from?
@export var ghost_mount : GhostMount

@export var fire_period_s : float = 1
var current_fire_cooldown : float = 0

func fire() -> void:
	if !current_fire_cooldown == 0:
		return
	current_fire_cooldown = fire_period_s
	var look_point = hitscan_manager.get_look_point()
	var destination : Vector3 = look_point if look_point else -global_transform.basis.z
	
	var new_rocket = rocket.instantiate()
	get_node("/root").add_child(new_rocket)
	new_rocket.global_transform.origin = global_transform.origin
	new_rocket.look_at(destination)


func _physics_process(delta: float) -> void:
	if ghost_mount.get_ghost_inputs().primary_depressed:
		fire()
	current_fire_cooldown = max(0, current_fire_cooldown - delta)
