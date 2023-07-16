extends Node
## This is anything that can give inputs to a body (aka a shell).
## It can be controlled either by a player input, or an AI.
class_name Ghost


# An action is what we're doing, a payload is data related to that action.
# For example, strafing left will be sent as "moving", (-1, 0)
signal emitted_output(action: String, payload)

## What is the ghost mount that we are connected to? This lets us get information about
## the shell.
@export var ghost_mount : GhostMount

# Our current input.
var current_inputs : GhostInput = GhostInput.new()
