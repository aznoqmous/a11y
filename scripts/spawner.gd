class_name Spawner extends Node2D

@export var spawn_parent : Node2D
@export var spawn_starting_coins := 3.0
@export var spawn_cooldown := 3.0
@export var spawn_cooldown_scaling := 0.1
@export var spawn_base_gain := 0.3
@export var spawn_gain_increment := 0.1
@export var on_spawn_cooldown := 1.0
@export var on_spawn_cooldown_scaling := 0.1
@export var on_spawn_cooldown_min := 0.2
@export var spawn_points : Array[Node2D]
@export var spawned_resources : Array[SpawnedResource]

var last_spawn_point : Node2D
var spawn_gain := 0.0
var coins := 1.0
var spawn_time := 0.0

func _ready():
	coins = spawn_starting_coins
	spawn_gain = spawn_base_gain

func _process(delta):
	coins += delta * spawn_base_gain
	spawn_time -= delta
	spawn_gain += spawn_gain_increment * delta
	on_spawn_cooldown = max(on_spawn_cooldown_min, on_spawn_cooldown * (1.0 - on_spawn_cooldown_scaling * delta))
	spawn_cooldown = max(0.1, spawn_cooldown - spawn_cooldown_scaling * delta)
	
	if spawn_time < 0:
		spawn()
		
func spawn():
	var available_resources = spawned_resources.filter(func(a: SpawnedResource): return a.cost < coins)
	if available_resources.size() <= 0:
		spawn_time = spawn_cooldown
		return;
	spawn_time = on_spawn_cooldown
	var spawned : SpawnedResource = available_resources.pick_random()
	coins -= spawned.cost
	var spawned_instance = spawned.packed_scene.instantiate()
	var spawn_point = spawn_points.filter(func(a): return a != last_spawn_point).pick_random()
	last_spawn_point = spawn_point
	spawn_parent.add_child(spawned_instance)
	spawned_instance.global_position = spawn_point.global_position
	on_spawn.emit(spawned_instance, spawn_points.find(spawn_point))
	
signal on_spawn(foe: Foe, spawn_index: int)
