extends Node3D
class_name Checkpoint

# This class is a checkpoint that the player can walk through to save their
# progress.

# Emit this signal when a player enters the checkpoint.
signal checkpoint_activated(player: Shell)

func _on_area_3d_body_entered(body) -> void:
	if body == PlayerInfo.current_player_shell :
		checkpoint_activated.emit(body)
		# Change this later - it's not good to have a direct reference to the particles.
		$Lantern/CSGBox3D3/GPUParticles3D.emitting = true
