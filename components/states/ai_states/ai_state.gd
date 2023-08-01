extends State
class_name AiState

# This class is for states that are specifically used as AI logic. It contains
# some helper functions, like converting a global position into inputs
# to get there, as well as facing towards something, etc.

# This function takes a vector3 in global space amd returns mouse inputs that will move the 
# body towards facing this point on the y-axis by some speed.
# this function works in radians, by the way.

# We deal with yaw and pitch separately. In both cases, we get the target position relative to us.
# then for yaw, we project the position onto the horizontal (XZ plane) and get the angle from our forward direction to that point.
# We save the sign (direction), and then rotate by whichever is smaller: the angle itself, or the amount our rotation speed lets us rotate. This is to avoid
# jittering where we constantly over or undershoot the position.
func look_towards_y(pos: Vector3, rotation_speed: float, delta: float) -> Vector2:
	var local_pos : Vector3 = user.ghost_mount.shell.to_local(pos)
	var y_angle : float = Vector3.FORWARD.angle_to(local_pos * Vector3(1, 0, 1)) * sign(local_pos.x)
	return Vector2(sign(y_angle) * min(delta * rotation_speed, abs(y_angle)),0)

# Pitch is similar, but we project onto the ZY plane. We also need to get the position relative to the
# shell's *head*, since that is the part that pitches.
func look_towards_x(pos: Vector3, rotation_speed: float, delta: float) -> Vector2:
	var local_pos : Vector3 = user.ghost_mount.shell.head.to_local(pos)
	var x_angle : float = -Vector3.UP.angle_to(local_pos * Vector3(0, 1, 1)) * sign(local_pos.y)
	return Vector2(0,sign(x_angle) * min(delta * rotation_speed, abs(x_angle)))

func aim_at(pos: Vector3, pitch_speed: float, yaw_speed: float, delta: float) -> Vector2:
	return Vector2(look_towards_y(pos, yaw_speed, delta).x, look_towards_x(pos, pitch_speed, delta).y)

# This function takes a position in global space, and tells us which directional inputs will move
# us in that direction, factoring in where we are looking.
func input_move_towards(destination: Vector3) -> Vector2:
	# that function gives us a path position in global space, but we need it in local space.
	var next_velocity : Vector3 = user.to_local(destination)
	return Vector2(next_velocity.x, -next_velocity.z).normalized()
