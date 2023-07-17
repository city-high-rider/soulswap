extends Shell

# This is the machinegun roller's shell.

# Reference to the machine guns.
@onready var machine_gun_1 : Node3D = $Camera3D/MachineGun
@onready var machine_gun_2 : Node3D = $Camera3D/MachineGun2

func _physics_process(delta: float) -> void:
	super(delta)
		
