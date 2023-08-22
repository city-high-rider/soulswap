extends Node3D
## This is a node that represents a buff. It should be a child of BuffManager
class_name ShellBuff

# Potential bug: If we have buffs that both add to a stat and multiply it by something,
# we need to be careful of the order in which we remove them to get it back to the original
# amount correctly

# Invoked by buff manager when we apply the buff. This function is applied to each health component
# / weapon
func on_apply_change_health(_health_component : HealthComponent) -> void:
	pass

func on_apply_change_weapons(_weapon : Node) -> void:
	pass
	
func on_wearoff_change_health(_health_component : HealthComponent) -> void:
	pass

func on_wearoff_change_weapons(_weapon : Node) -> void:
	pass
