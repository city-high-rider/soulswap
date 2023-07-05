extends Node3D

# This is a machine gun that you can put onto enemy bodies.

# references to particles etc.

@onready var muzzle_flash : GPUParticles3D = $MuzzleFlash
@onready var shells : GPUParticles3D = $Shells

# Where should we start drawing the tracer from?
@onready var barrel_point : Marker3D = $BarrelPoint

# Start the shooting effects
func start_shooting() -> void:
	muzzle_flash.emitting = true
	shells.emitting = true
	
# Stop the shooting effects
func stop_shooting() -> void:
	muzzle_flash.emitting = false
	shells.emitting = false
