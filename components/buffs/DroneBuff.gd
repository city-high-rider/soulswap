extends ShellBuff

## How much should we multiply max health by?
@export var extra_hp_mult : float = 2

func on_apply_change_health(health_component : HealthComponent) -> void:
	health_component.max_health *= extra_hp_mult

	
func on_wearoff_change_health(health_component : HealthComponent) -> void:
	health_component.max_health /= extra_hp_mult
