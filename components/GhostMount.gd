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
signal ghost_changed(new_ghost: Ghost)
