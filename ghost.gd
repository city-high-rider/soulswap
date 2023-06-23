extends Node
class_name Ghost

# This is anything that can give inputs to a body (aka a shell).
# It can be controlled either by a player input, or an AI.

# An action is what we're doing, a payload is data related to that action.
# For example, strafing left will be sent as "moving", (-1, 0)
signal emitted_output(action: String, payload)
