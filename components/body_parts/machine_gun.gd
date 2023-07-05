extends Node3D

# This is a machine gun that you can put onto enemy bodies.

# references to particles etc.

@onready var muzzle_flash : GPUParticles3D = $MuzzleFlash
@onready var shells : GPUParticles3D = $Shells

# Where should we start drawing the tracer from?
@onready var barrel_point : Marker3D = $BarrelPoint

# Where should we show the player the current ammo?
@onready var ammo_counter : Label3D = $UI/AmmoCount

# Since this is functionally like a laser gun, instead of measuring how many
# bullets we have left, we mesure how much longer we can fire the gun.
@export var firing_time_sec : float = 10
var firing_time_left : float = firing_time_sec

var is_broken : bool = false
var is_shooting : bool = false

func _ready() -> void:
	is_broken = false

func _physics_process(delta: float) -> void:
	if is_shooting:
		firing_time_left = max(0, firing_time_left - delta)
		ammo_counter.text = "Ammo left: " + str(snapped((firing_time_left / firing_time_sec), 0.01))
	
	if firing_time_left <= 0:
		stop_shooting()
		
# Start the shooting effects
func start_shooting() -> void:
	if is_broken or firing_time_left <= 0:
		return
	muzzle_flash.emitting = true
	shells.emitting = true
	is_shooting = true
	
# Stop the shooting effects
func stop_shooting() -> void:
	muzzle_flash.emitting = false
	shells.emitting = false
	is_shooting = false


func _on_health_component_died():
	is_broken = true
	stop_shooting()
	ammo_counter.text = "BROKEN!"
