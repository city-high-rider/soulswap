extends MeshInstance3D
class_name Tracer

# This is a tracer that is used for hitscan weapons. It should spawn and then fade away.
@onready var animation_player : AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	animation_player.play("fade")
	await animation_player.animation_finished
	queue_free()
