extends Node
class_name HitscanManager

## this is a node that manages hitscan weapons. It is responsible for calling the
## take_damage function on hitboxes and drawing tracers.

## which raycast should we use to check for collisions?
@export var raycast : RayCast3D

# Set at runtime by the head.
var associated_shell : Shell = null

# this function should be called by a hitscan weapon when it fires, to which
# it will pass its damage. We will check for a hit, and if there is one,
# we pass some damage. Returns whether or not we hit an enemy.
func check_hit(damage: Damage, tracer: PackedScene, barrel_pos: Vector3) -> bool:
	var collider = raycast.get_collider()
	if !collider:
		return false
	
	if collider is Hitbox:
		collider.take_damage(damage, associated_shell)
		
	var new_tracer = tracer.instantiate()
	var hit_pos : Vector3 = raycast.get_collision_point()
	add_child(new_tracer)
	new_tracer.global_transform.origin = barrel_pos + (hit_pos - barrel_pos) / 2
	new_tracer.mesh.height = barrel_pos.distance_to(hit_pos)
	new_tracer.look_at(hit_pos)
	new_tracer.rotate_x(PI/2)
	return collider is Hitbox

func get_look_point():
	return null if !raycast.is_colliding() else raycast.get_collision_point()
