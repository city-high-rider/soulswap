extends Node3D
## this is for the energy pellet projectile.


func _on_area_3d_area_entered(area):
	if area is Hitbox:
		area.take_damage(10, null)