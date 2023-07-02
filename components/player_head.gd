extends Camera3D
class_name PlayerHead

# This class is the player's "head". It's stuff that the player should always have, regardless
# of which body they are controlling. For example, a camera and a raycast to tell where they are aiming.

@onready var look_ray : RayCast3D = $RayCast3D
