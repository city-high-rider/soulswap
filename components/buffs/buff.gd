extends Node
## This is a node that represents a buff. It should be a child of BuffManager
class_name ShellBuff

# Invoked by buff manager when we apply the buff. This function is applied to each health component
# / weapon
func on_apply_change_health(health_component : HealthComponent) -> void:
	pass

func on_apply_change_weapons(weapon : Node) -> void:
	pass
	
func on_wearoff_change_health(health_component : HealthComponent) -> void:
	pass

func on_wearoff_change_weapons(weapon : Node) -> void:
	pass
