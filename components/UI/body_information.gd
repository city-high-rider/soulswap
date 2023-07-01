@tool
# Make this a tool so that we can actually preview the UI in the editor.

extends MarginContainer
class_name BodyInformationPopup
# This class shows the player the controls of the body when they possess it. 

# What's the name of the body that we are controlling?
@export var shell_name : String = "??"

# What are some things that the player should know about this body?
@export_multiline var shell_description : String = ""

# References to the labels:
@onready var name_label : Label = $VBoxContainer/BodyName
@onready var info_label : Label = $VBoxContainer/BodyInfo

func _ready() -> void:
	name_label.text = "You are controlling: " + shell_name
	info_label.text = shell_description
