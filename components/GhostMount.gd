extends Node3D
class_name GhostMount

# While the body's movement logic and the ghost should be separate, there is still some information
# that they need to share. The ghost should be a child of this node, and other nodes can connect to it
# such as the state machine. By connecting everything to one spot, it makes it easy to change out the ghost.

# What is our ghost?
@export var ghost : Ghost 

# Which body are we connecting to the ghost?
@export var shell : Shell

# Emit this signal when the ghost changes, so that we can re-initialise state machines, etc.
signal ghost_changed(new_ghost: Ghost, is_player: bool)

# Emit this signal when the ghost outputs anything
signal ghost_emitted_output(action: String, payload)

func _ready() -> void:
	change_ghost(ghost)

func change_ghost(new_ghost: Ghost) -> void:
	# first, get rid of the current ghost.
	if ghost != new_ghost:
		remove_child(ghost)
		ghost.queue_free()
	
	# Deal with signals.
	if ghost.emitted_output.is_connected(_on_ghost_emitted_output):
		ghost.emitted_output.disconnect(_on_ghost_emitted_output)
	if !new_ghost.emitted_output.is_connected(_on_ghost_emitted_output):
		new_ghost.emitted_output.connect(_on_ghost_emitted_output)
	
	# then, attach the new one.
	new_ghost.reparent(self, false)
	ghost = new_ghost
	
	
	# Check if it is a player ghost
	if ghost is PlayerGhost:
		PlayerInfo.current_player_shell = shell
		emit_signal("ghost_changed", ghost, true)
	else:
		emit_signal("ghost_changed", ghost, false)

func _on_ghost_emitted_output(action: String, payload) -> void:
	emit_signal("ghost_emitted_output", action, payload)
