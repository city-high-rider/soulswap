extends Projectile
## this is for the energy pellet projectile.

func _init() -> void:
	on_collide = queue_free
	on_hitbox_collide = queue_free
