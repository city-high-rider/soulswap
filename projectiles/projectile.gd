extends CharacterBody3D

## This class is for projectiles (things like rockets, fireballs, etc.).
## Collision should mask the hitboxes layer. Hitboxes are responsible for detecting it.

class_name Projectile

## How much / what type of damage do we deal on contact?
@export var damage : Damage = Damage.new()

## How fast does this projectile fly?
@export var speed : float = 20

## How long should we wait before despawning the projectile?
@export var despawn_time_s : float = 10

# What function should we call on collision?
var on_collide : Callable = func(): pass
# What function should we call on hitbox collision? This is called by the hitbox.
# it should NOT deal any damage as this is handled by the hitbox.
# The on_collide function is NOT called when we hit a hitbox.
var on_hitbox_collide : Callable = func(): pass

# Reference to whoever shot the projectile. Set upon instantiation by the projectile launcher.
# This is used to detect who shot who by the style system.
var thrower : Node = null


func _ready() -> void:
	get_tree().create_timer(despawn_time_s).timeout.connect(queue_free)


func _physics_process(delta: float) -> void:
	# By default, fly in the -ve z direction.
	velocity = speed * -global_transform.basis.z
	# If we hit something, run the on_collide function
	if move_and_slide():
		on_collide.call()
