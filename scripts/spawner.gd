class_name Spawner extends Node2D

@export var spawn_parent : Node2D
@export var spawn_points : Array[Node2D]
@export var spawn_cooldown := 3.0
@export var spawn_base_gain := 0.3
@export var spawned_resources : Array[SpawnedResource]

var coins := 1.0
var spawn_time := 0.0

func _process(delta):
	coins += delta * spawn_base_gain
	spawn_time -= delta
	if spawn_time < 0:
		spawn()
		
func spawn():
	var available_resources = spawned_resources.filter(func(a: SpawnedResource): return a.cost < coins)
	print("SPAWN ", available_resources.size(), " ", coins)
	if available_resources.size() <= 0:
		spawn_time = spawn_cooldown
		return;
	var spawned : SpawnedResource = available_resources.pick_random()
	coins -= spawned.cost
	var spawned_instance = spawned.packed_scene.instantiate()
	var spawn_point = spawn_points.pick_random()
	spawn_parent.add_child(spawned_instance)
	spawned_instance.global_position = spawn_point.global_position
	
