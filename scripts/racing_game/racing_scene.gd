extends Node2D

@export var lanes : Array[Node2D]

var selected_lane_index = 1
var selected_lane : Node2D :
	get : return lanes[selected_lane_index] 

var access_direction = 1

@onready var player: RacingPlayer = $World/Player
@onready var spawner: Spawner = $Spawner
@onready var world: Node2D = $World
@onready var parallax_2d: Parallax2D = $Decor/Parallax2D


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Up"):
		selected_lane_index = clamp(selected_lane_index - 1, 0, lanes.size() - 1)
	if event.is_action_pressed("Down"):
		selected_lane_index = clamp(selected_lane_index + 1, 0, lanes.size() - 1)
	if event.is_action_pressed("Space"):
		if selected_lane_index + access_direction < 0 or selected_lane_index + access_direction >= lanes.size():
			access_direction = -access_direction
		selected_lane_index += access_direction

func _process(delta):
	player.position = player.position.lerp(selected_lane.position, delta * 10.0)
