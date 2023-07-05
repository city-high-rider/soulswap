extends Node
class_name HitscanManager

# this is a node that manages hitscan weapons. It is responsible for calling the
# take_damage function on hitboxes and drawing tracers.

# which raycast should we use to check for collisions?
@export var raycast : RayCast3D

# this function should be called by a hitscan weapon when it fires, to which
# it will pass its damage. We will check for a hit, and if there is one,
# we pass some damage. Returns whether or not we hit an enemy.
func check_hit(damage: float, tracer: PackedScene, barrel_pos: Vector3) -> bool:
	var collider = raycast.get_collider()
	if !collider:
		return false
	
	if collider is Hitbox:
		collider.take_damage(damage)
		return true
		
	return false
