extends Label


func _on_head_aimed_at(shell: Shell) -> void:
	if !shell:
		text = ""
	else:
		text = "Possess cost: " + str(shell.possess_cost)
