extends Node3D
## Multiple wave spawner. We just use a bunch of wave_spawners but connect the finished signal of the nth
## wave to the start signal of the n+1 st wave.

var waves : Array[Node] = []

signal encounter_started
signal encounter_ended

func _ready() -> void:
	waves = get_children().filter(func(c): return c is WaveSpawner)
	# Starting at the second wave, connect the start signal to the end signal of the one before it
	for w in range(1, len(waves)):
		waves[w-1].all_enemies_killed.connect(waves[w].start)
	# Connect the main end signal to the end signal of the last wave.
	waves[len(waves)-1].all_enemies_killed.connect(func(): encounter_ended.emit())
	
func start() -> void:
	if waves[0]:
		waves[0].start()
