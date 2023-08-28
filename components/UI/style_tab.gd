extends Control
## Label settings for the style labels.
@export var style_label_settings : LabelSettings = LabelSettings.new()

@onready var style_label : Label = $PanelContainer/VBoxContainer/TotalStyle

@onready var logs : VBoxContainer = $PanelContainer/VBoxContainer/Logs

func display_style(message: String, points : int ) -> void:
	# Create a timer that will count down for 2.5 seconds
	var show_timer : SceneTreeTimer = get_tree().create_timer(2.5)
	# Create and set the actual text node
	var new_label : Label = Label.new()
	new_label.text = message
	new_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	new_label.label_settings = style_label_settings
	# delete that node when the timer runs out.
	show_timer.timeout.connect(func(): new_label.queue_free())
	
	logs.add_child(new_label)


func _on_player_ghost_style_changed(new_style: int) -> void:
	style_label.text = "STYLE: " + str(new_style) + " PTS"
