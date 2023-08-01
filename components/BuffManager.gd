extends Node
## This node keeps track of health / damage buffs that are specific to the shell.
## It is responsible for modifying health / weapons components when buffs are added / run out.
class_name BuffManager

## What health components are affected by our buffs?
@export var health_components : Array[HealthComponent]

## Which weapons are affected by our buffs?
@export var weapons : Array[Node]
