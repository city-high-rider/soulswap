extends Ghost
## This is a ghost which is controlled by the player.
class_name PlayerGhost

## What's our mouse sensitivity?
@export var mouse_sensitivity : float = 0.1

# Reference to the death screen GUI.
@onready var death_screen : Control = $DeathScreen

# Reference to the style tab.
@onready var style_tab : Control = $StyleTab

# The amount of style points the player has
var style_points : int = 20:
	set(value):
		style_changed.emit(value)
		style_points = value

signal style_changed(new_style: float)

var saved_style_pts : int = style_points

func _ready() -> void:
	# capture the mouse in the middle of the screen
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	CheckpointManager.checkpoint_activated.connect(save_data)
	CheckpointManager.load_checkpoint.connect(load_data)

func _process(_delta: float) -> void:
	# We set this to zero, so that the mouse doesn't drift when we stop looking around.
	current_inputs.mouse_direction = Vector2.ZERO
	
	var move_input: Vector2 = Input.get_vector("left", "right", "back", "forward")
	if move_input:
		current_inputs.input_direction = move_input
	else:
		current_inputs.input_direction = Vector2.ZERO
		
	current_inputs.primary_depressed = Input.is_action_pressed("primary_action")
	
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		current_inputs.mouse_direction = Vector2(deg_to_rad(event.relative.x), deg_to_rad(event.relative.y)) * mouse_sensitivity
		
	if Input.is_action_just_pressed("possess"):
		emit_signal("emitted_output", "possess", null)
	
	if Input.is_action_just_pressed("toggle_info"):
		emit_signal("emitted_output", "toggle_info", null)
	
	if Input.is_action_just_pressed("jump"):
		emit_signal("emitted_output", "jump", null)

func on_shell_death() -> void:
	death_screen.show()
	
func save_data() -> void:
	saved_style_pts = style_points

func load_data() -> void:
	style_points = saved_style_pts

func award_style(pts: int, message: String) -> void:
	style_points += pts
	style_tab.display_style(message, pts)
	
