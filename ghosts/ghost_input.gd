extends Resource
## Resource that describes the current inputs the ghost is sending to the body.
class_name GhostInput
# Sometimes, especially for something that needs to be snappy like movement, we need to rely on
# polling instead of just sending signals. This is because signals are not tied to framerate, so you
# get really weird behaviour like accelerating faster if you shake your mouse. However, we can't use
# Input.is_action_just_pressed, as that would not be getting the input from the ghost. So here
# we define some variables which the player state machine can then read.

## Which direction do we want to move in?
@export var input_direction : Vector2 = Vector2.ZERO

## Which direction are we moving the mouse in? This can be (and is, in the player controller) multiplied
## by some sensitivity.
@export var mouse_direction : Vector2 = Vector2.ZERO

## Are we holding down the primary action? Usually this is firing bound to mouse one.
@export var primary_depressed : bool = false
