extends Ghost

# Which state machine are we using?
@export var state_machine : StateMachine

func _ready() -> void:
	state_machine.init(self)
	
func _physics_process(delta: float):
	state_machine.handle_physics(delta)
