extends ShellBuff

## How much should we multiply max health by?
@export var extra_hp_mult : float = 10

func on_apply_change_health(health_component : HealthComponent) -> void:
	health_component.max_health *= extra_hp_mult
	health_component.current_health = health_component.max_health

	
func on_wearoff_change_health(health_component : HealthComponent) -> void:
	health_component.max_health /= extra_hp_mult
	health_component.current_health = health_component.max_health
