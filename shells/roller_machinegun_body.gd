extends Shell

# This is the machinegun roller's shell.

# Reference to the machine guns.
@onready var machine_gun_1 : Node3D = $Camera3D/MachineGun
@onready var machine_gun_2 : Node3D = $Camera3D/MachineGun2

func _physics_process(delta: float) -> void:
	super(delta)
	if ghost_mount.get_ghost_inputs().primary_depressed:
		machine_gun_1.start_shooting()
		machine_gun_2.start_shooting()
	else:
		machine_gun_1.stop_shooting()
		machine_gun_2.stop_shooting()
		
