extends Node3D
## This is a base for a weapon that shoots projectiles, such as a 
## rocket or a fireball

## what are we shooting?
@export var projectile : PackedScene 

## Which ghost mount are we listening to for input?
@export var ghost_mount : GhostMount

## Which hitscan manager are we using?
@export var hitscan_manager : HitscanManager

## How long is the firing cooldown?
@export var fire_period_s : float = .2
var current_fire_cooldown = fire_period_s

## Where should the projectile be spawned?
@export var barrel_pos : Marker3D

## How fast do we shoot the projectile?
@export var muzzle_speed : float = 20

## Which audio player do we use for gunfire sound?
@export var gunfire_sound : AudioQueue3D

func fire():
	if current_fire_cooldown > 0:
		return
	current_fire_cooldown = fire_period_s
	var new_projectile = projectile.instantiate()
	get_node("/root").add_child(new_projectile)
	new_projectile.global_transform.origin = global_transform.origin if !barrel_pos else barrel_pos.global_transform.origin
	var destination : Vector3 = get_destination_point()
	new_projectile.look_at(destination)
	if "linear_velocity" in new_projectile:
		new_projectile.linear_velocity = (destination - new_projectile.global_transform.origin).normalized() * muzzle_speed
	if gunfire_sound:
		gunfire_sound.play_sound()
	
	

func _physics_process(delta: float) -> void:
	if ghost_mount.get_ghost_inputs().primary_depressed:
		fire()
	current_fire_cooldown = max(0, current_fire_cooldown - delta)
	
func get_destination_point() -> Vector3:
	# If we aren't looking at anything than the destination is in front of the barrel if we have one, or in front of the gun.
	var backup_point : Vector3 = global_transform.basis.z + global_transform.origin if !barrel_pos else barrel_pos.global_transform.origin + barrel_pos.global_transform.basis.z
	# If we have a hitscan manager that is colliding, then the collision point is our priority
	if hitscan_manager and hitscan_manager.get_look_point():
		return hitscan_manager.get_look_point()
	else:
		return backup_point
