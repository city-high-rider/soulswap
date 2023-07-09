extends Ghost

# Which state machine are we using?
@onready var state_machine : StateMachine = $StateMachine

func _ready() -> void:
	state_machine.init(self)
	
func _physics_process(delta: float) -> void:
	state_machine.handle_physics(delta)
