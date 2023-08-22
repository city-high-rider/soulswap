extends CharacterBody3D

## This class is for projectiles (things like rockets, fireballs, etc.)

class_name Projectile

## How much / what type of damage do we deal on contact?
@export var damage : Damage = Damage.new()

## How fast does this projectile fly?
@export var speed : float = 20

## How long should we wait before despawning the projectile?
@export var despawn_time_s : float = 10

func _ready() -> void:
	get_tree().create_timer(despawn_time_s).timeout.connect(queue_free)

# Call this function when the projectile hits something (player / wall, etc)
func on_collision() -> void:
	pass

func _physics_process(delta: float) -> void:
	# By default, fly in the -ve z direction.
	velocity = speed * -global_transform.basis.z
	var collided : bool = move_and_slide()
	if collided:
		on_collision()
		
