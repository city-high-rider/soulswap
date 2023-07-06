extends Node3D

# This is a machine gun that you can put onto enemy bodies.

# references to particles etc.

@onready var muzzle_flash : GPUParticles3D = $MuzzleFlash
@onready var shells : GPUParticles3D = $Shells

# Where should we start drawing the tracer from?
@onready var barrel_point : Marker3D = $BarrelPoint

# Since this is functionally like a laser gun, instead of measuring how many
# bullets we have left, we mesure how much longer we can fire the gun.
@export var firing_time_sec : float = 10

# How often do we check for a hit?
@export var hit_poll_period_s : float = 0.15
var time_until_next_poll : float = hit_poll_period_s

# How much damage per hit?
@export var hit_damage : float = 2

# Which hitscan manager should we call to?
@export var hitscan_manager : HitscanManager

# Which tracers should we use?
@export var tracer_scene : PackedScene

var firing_time_left : float = firing_time_sec

var is_broken : bool = false
var is_shooting : bool = false

func _ready() -> void:
	is_broken = false

func _physics_process(delta: float) -> void:
	if is_shooting:
		firing_time_left = max(0, firing_time_left - delta)
		
		time_until_next_poll = max(0, time_until_next_poll - delta)
	
	if firing_time_left <= 0:
		stop_shooting()
	
	if time_until_next_poll <= 0:
		hitscan_manager.check_hit(hit_damage, tracer_scene, barrel_point.global_transform.origin)
		
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
