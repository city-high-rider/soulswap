extends Node
## This node keeps track of health / damage buffs that are specific to the shell.
## It is responsible for modifying health / weapons components when buffs are added / run out.
class_name BuffManager

## What health components are affected by our buffs?
@export var health_components : Array[HealthComponent]

## Which weapons are affected by our buffs?
@export var weapons : Array[Node]

func _ready() -> void:
	# yes, this means we don't save buffs on checkpoints. But it shouldn't matter since
	# we only get buffs in combat, in other words AFTER we hit a checkpoint.
	# this is something to implement later.
	CheckpointManager.load_checkpoint.connect(clear_all_buffs)


func apply_buff(buff: ShellBuff) -> void:
	add_child(buff)
	for hc in health_components:
		buff.on_apply_change_health(hc)
	for weapon in weapons:
		buff.on_apply_change_weapons(weapon)

func remove_buff(buff: ShellBuff) -> void:
	for hc in health_components:
		buff.on_wearoff_change_health(hc)
	for weapon in weapons:
		buff.on_wearoff_change_weapons(weapon)
	remove_child(buff)
	buff.queue_free()


func _on_shell_died():
	clear_all_buffs()


func clear_all_buffs() -> void:
	for buff in get_children().filter(func(c): return c is ShellBuff):
		remove_buff(buff)
