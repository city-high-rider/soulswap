extends Node3D

## This is a machine gun that you can put onto enemy bodies.

## references to particles etc.

@onready var muzzle_flash : GPUParticles3D = $MuzzleFlash
@onready var gunfire : AudioQueue3D = $AudioQueue3D
@onready var break_sound : AudioStreamPlayer3D = $Break
@onready var break_particles : GPUParticles3D = $BreakParticles

# Where should we start drawing the tracer from?
@onready var barrel_point : Marker3D = $BarrelPoint

## Since this is functionally like a laser gun, instead of measuring how many
## bullets we have left, we mesure how much longer we can fire the gun.
@export var firing_time_sec : float = 10

## How often do we check for a hit?
@export var hit_poll_period_s : float = 0.08
var time_until_next_poll : float = hit_poll_period_s

## How much damage per hit?
@export var hit_damage : Damage = Damage.new()

## Which hitscan manager should we call to?
@export var hitscan_manager : HitscanManager

## Which tracers should we use?
@export var tracer_scene : PackedScene

## Which ghost mount is ours?
@export var ghost_mount : GhostMount

var firing_time_left : float = firing_time_sec

var is_broken : bool = false
var is_shooting : bool = false

var current_save : GunSave = GunSave.new()

func _ready() -> void:
	is_broken = false
	CheckpointManager.checkpoint_activated.connect(save_data)
	CheckpointManager.load_checkpoint.connect(load_data)
	save_data()

func _physics_process(delta: float) -> void:
	if is_shooting:
		firing_time_left = max(0, firing_time_left - delta)
		
		time_until_next_poll = max(0, time_until_next_poll - delta)
	
	if firing_time_left <= 0:
		stop_shooting()
	
	if time_until_next_poll <= 0:
		var modified_hit : Damage = hit_damage.duplicate()
		modified_hit.damage_amount *= ghost_mount.get_ghost_modifiers().base_damage_multiplier
		hitscan_manager.check_hit(modified_hit, tracer_scene, barrel_point.global_transform.origin)
		time_until_next_poll = hit_poll_period_s
		gunfire.play_sound()
		
	if ghost_mount.get_ghost_inputs().primary_depressed:
		start_shooting()
	else:
		stop_shooting()
		
# Start the shooting effects
func start_shooting() -> void:
	if is_broken or firing_time_left <= 0:
		return
	muzzle_flash.emitting = true
	is_shooting = true
	
# Stop the shooting effects
func stop_shooting() -> void:
	muzzle_flash.emitting = false
	is_shooting = false


func save_data() -> void:
	current_save.is_broken = is_broken
	current_save.saved_ammo = firing_time_left

func load_data() -> void:
	is_broken = current_save.is_broken
	firing_time_left = current_save.saved_ammo


func _on_hitbox_took_damage(lethal, damage, attacker, _is_direct):
	if !lethal:
		return
		
	is_broken = true
	stop_shooting()
	break_particles.emitting = true
	if attacker is Shell and attacker.ghost_mount.ghost.has_method("award_style"):
		attacker.ghost_mount.ghost.award_style(StyleManager.STYLE_FOR_BREAKING_WEAKPOINT, "+ WEAKPOINT BREAK")
		break_sound.play()
