extends Resource
## This resource is any information that a HealthComponent might want to save 
## when a checkpoint is reached.
class_name HealthComponentSave

## What is the health it has?
@export var saved_health : int = 100

## What is the maximum amount of health it can have?
@export var saved_max_health : int = 100
