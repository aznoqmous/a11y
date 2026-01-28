extends Node2D

@export var lanes : Array[Node2D]
@export var alert_spawns : Array[Node2D]
@export var alert_scene : PackedScene

var selected_lane_index = 1
var selected_lane : Node2D :
	get : return lanes[selected_lane_index] 

var access_direction = 1

@onready var player: RacingPlayer = $World/Player
@onready var spawner: Spawner = $Spawner
@onready var world: Node2D = $World
@onready var parallax_2d: Parallax2D = $Decor/Parallax2D

func _ready():
	spawner.on_spawn.connect(func(foe, index):
		var alert = alert_scene.instantiate()
		alert_spawns[index].add_child(alert)
		alert.position = Vector2.LEFT.rotated(randf() * TAU) * randf() * 30.0
	)
	player.arrow_container.scale.y = -get_access_direction()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Up"):
		selected_lane_index = clamp(selected_lane_index - 1, 0, lanes.size() - 1)
		player.arrow_container.set_visible(false)

	if event.is_action_pressed("Down"):
		selected_lane_index = clamp(selected_lane_index + 1, 0, lanes.size() - 1)
		player.arrow_container.set_visible(false)
		
	if event.is_action_pressed("Space"):
		player.arrow_container.set_visible(true)
		access_direction = get_access_direction()
		selected_lane_index += access_direction
		player.arrow_container.scale.y = -get_access_direction()

func _process(delta):
	player.position = player.position.lerp(selected_lane.position, delta * 10.0)

func get_access_direction():
	var access_dir = access_direction
	if selected_lane_index + access_direction < 0 or selected_lane_index + access_direction >= lanes.size():
		access_dir = -access_dir
	return access_dir
