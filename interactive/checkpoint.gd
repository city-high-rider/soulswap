extends Node3D
## This class is a checkpoint that the player can walk through to save their
## progress.
class_name Checkpoint

# Reference to the audio players
@onready var ignite_audio : AudioStreamPlayer3D = $AudioStreamPlayer3D
@onready var ambient_audio : AudioStreamPlayer3D = $AudioStreamPlayer3D2

# Reference to the particles
@onready var particles : GPUParticles3D = $Lantern/CSGBox3D3/GPUParticles3D

# Reference to the light animation 
@onready var light_flicker : AnimationPlayer = $Lantern/CSGBox3D3/AnimationPlayer

# Emit this signal when a player enters the checkpoint.
signal checkpoint_activated(player: Shell)

func _on_area_3d_body_entered(body) -> void:
	if body == PlayerInfo.current_player_shell:
		ignite_audio.play()
		checkpoint_activated.emit(body)
		CheckpointManager.checkpoint_activated.emit()
		particles.set_emitting(true)
		light_flicker.play("light_flicker")
		
		if ambient_audio.finished.is_connected(ambient_audio.play):
			return
		ambient_audio.finished.connect(ambient_audio.play)
		ambient_audio.play()
