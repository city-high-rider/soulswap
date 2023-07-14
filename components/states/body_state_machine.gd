extends StateMachine
## this is a state machine that is used to control bodies using the input of a ghost.
class_name BodyStateMachine

## Which mount is the ghost connected to?
@export var ghost_mount : GhostMount

## What is the default death state?
@export var down_state : ShellState

func _ready() -> void:
	ghost_mount.ghost_changed.connect(_on_ghost_changed)
	ghost_mount.ghost_emitted_output.connect(handle_ghost_input)
	init(ghost_mount.shell)
	
	for state in get_children().filter(func(c): return c is ShellState):
		state.ghost = ghost_mount.ghost
		
	CheckpointManager.load_checkpoint.connect(checkpoint_load)
	
func _on_ghost_changed(new_ghost: Ghost, _is_player: bool) -> void:
	for state in get_children().filter(func(c): return c is ShellState):
		state.ghost = new_ghost
		
func _physics_process(delta: float) -> void:
	handle_physics(delta)

func handle_ghost_input(action: String, payload) -> void:
	current_state.handle_ghost_output(action, payload)

func _on_health_component_died() -> void:
	switch_state(down_state)

func checkpoint_load() -> void:
	switch_state(initial_state)
