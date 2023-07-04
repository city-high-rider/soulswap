extends State
class_name AiState

# This class is for states that are specifically used as AI logic. It contains
# some helper functions, like converting a global position into inputs
# to get there, as well as facing towards something, etc.

# This function takes a vector3 in global space amd returns mouse inputs that will move the 
# body towards facing this point on the y-axis by some speed.
func look_towards_y(pos: Vector3, rotation_speed: float, delta: float) -> Vector2:
	var local_pos : Vector3 = user.to_local(pos)
	var y_angle : float = Vector3.FORWARD.angle_to(local_pos * Vector3(1, 0, 1)) * sign(local_pos.x)
	return Vector2(sign(y_angle) * min(delta * rotation_speed, abs(rad_to_deg(y_angle))),0)


# This function takes a position in global space, and tells us which directional inputs will move
# us in that direction, factoring in where we are looking.
func input_move_towards(destination: Vector3) -> Vector2:
	# that function gives us a path position in global space, but we need it in local space.
	var next_velocity : Vector3 = user.to_local(destination)
	return Vector2(next_velocity.x, -next_velocity.z).normalized()
