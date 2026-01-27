extends Node

var current_scene = null
var shmup_scene = "res://scenes/shmup_game/shmup_scene.tscn"
var racing_scene = "res://scenes/racing_game/racing_scene.tscn"
var platformer_scene = "res://scenes/platformer_game/platformer_scene.tscn"

var title_scene = "res://scenes/title.tscn"
#var credits_scene = "res://scenes/credits.tscn"

var game_index = 0
var games : Array[String] = [
	racing_scene,
	shmup_scene,
	platformer_scene
]

var run_time = 0
var coin_count = 0
var max_coins = 0
var reset_count = 0

#const SCENE_MANAGER_PROGRESS = preload("res://scenes/scene_manager_progress.tscn")
var scene_manager_progress

func _ready():
	
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)
	
	#scene_manager_progress = SCENE_MANAGER_PROGRESS.instantiate()
	add_child(scene_manager_progress)
	
func load_title():
	load_scene_progress(title_scene)

func load_scene(path):
	_deferred_goto_scene.call_deferred(path)

func _deferred_goto_scene(path):
	var s = ResourceLoader.load(path)
	set_scene(s.instantiate())
	
func set_scene(scene):
	get_tree().current_scene.free()
	current_scene = scene
	get_tree().root.add_child(current_scene)
	get_tree().current_scene = current_scene

func load_scene_progress(path):
	scene_manager_progress.visible = true
	await scene_manager_progress.appear()
	
	var s = await _thread_load(path)
	set_scene(s.instantiate())
	
	await scene_manager_progress.disappear()
	scene_manager_progress.visible = false

func next_game():
	game_index = (game_index + 1) % games.size()
	load_scene(games[game_index])

func _thread_load(path):
	ResourceLoader.load_threaded_request(path)
	var tree = get_tree()
	var progress = 0
	var arrProgress = [0]
	while progress < 1:
		await tree.process_frame
		ResourceLoader.load_threaded_get_status(path, arrProgress)
		progress = arrProgress[0]
	return ResourceLoader.load_threaded_get(path)
	
