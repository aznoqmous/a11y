class_name PlatformerScene extends Node
@onready var camera_2d: Camera2D = $Camera2D
@onready var player: PlatformerPlayer = $World/Player
@onready var death_zone: Area2D = $DeathZone

var camera_target_position

func _ready():
	camera_target_position = camera_2d.global_position
	death_zone.body_entered.connect(func(body: PlatformerPlayer):
		SceneManager.next_game()
	)
	
func _process(delta: float) -> void:
	if player.global_position.x > camera_target_position.x:
		camera_target_position.x = player.global_position.x
	camera_2d.global_position = lerp(camera_2d.global_position, camera_target_position, delta * 5.0)
