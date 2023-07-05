extends Ghost
class_name PlayerGhost
# This is a ghost which is controlled by the player.

# What's our mouse sensitivity?
@export var mouse_sensitivity : float = 0.1

func _ready() -> void:
	# capture the mouse in the middle of the screen
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _process(_delta: float) -> void:
	# We set this to zero, so that the mouse doesn't drift when we stop looking around.
	mouse_direction = Vector2.ZERO
	
	var move_input: Vector2 = Input.get_vector("left", "right", "back", "forward")
	if move_input:
		input_direction = move_input
	else:
		input_direction = Vector2.ZERO
		
	primary_depressed = Input.is_action_pressed("primary_action")
	
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		mouse_direction = Vector2(deg_to_rad(event.relative.x), deg_to_rad(event.relative.y)) * mouse_sensitivity
		
	if Input.is_action_just_pressed("possess"):
		emit_signal("emitted_output", "possess", null)
	
	if Input.is_action_just_pressed("toggle_info"):
		emit_signal("emitted_output", "toggle_info", null)
	
	if Input.is_action_just_pressed("jump"):
		emit_signal("emitted_output", "jump", null)
