extends CharacterBody3D
class_name PossessableBody

# this class is any character body that can be possessed by the player. While this is
# pretty flexible, there are a few things that we need to have.

# Which camera should we look out of?
@export var body_camera : Camera3D

# Which state machine should the player control?
@export var player_state_machine : StateMachine

# What's the main health component? If its health drops to zero, the body dies.
@export var main_health : HealthComponent

