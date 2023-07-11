extends Node
class_name Ghost

# This is anything that can give inputs to a body (aka a shell).
# It can be controlled either by a player input, or an AI.

# An action is what we're doing, a payload is data related to that action.
# For example, strafing left will be sent as "moving", (-1, 0)
signal emitted_output(action: String, payload)

# What is the ghost mount that we are connected to? This lets us get information about
# the shell.
@export var ghost_mount : GhostMount

# Sometimes, especially for something that needs to be snappy like movement, we need to rely on
# polling instead of just sending signals. This is because signals are not tied to framerate, so you
# get really weird behaviour like accelerating faster if you shake your mouse. However, we can't use
# Input.is_action_just_pressed, as that would not be getting the input from the ghost. So here
# we define some variables which the player state machine can then read.

# Which direction do we want to move in?
var input_direction : Vector2 = Vector2.ZERO

# Which direction are we moving the mouse in? This can be (and is, in the player controller) multiplied
# by some sensitivity.
var mouse_direction : Vector2 = Vector2.ZERO

# Are we holding down the primary action? Usually this is firing bound to mouse one.
var primary_depressed : bool = false
