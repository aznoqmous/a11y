class_name PlatformerScene extends Node2D
@onready var camera_2d: Camera2D = $Camera2D
@onready var player: PlatformerPlayer = $World/Player
@onready var death_zone: Area2D = $DeathZone
@onready var parallax_sprite_2d: Sprite2D = $Decor/BackgroundParallax/ParallaxSprite2D

var camera_target_position

func _ready():
	camera_target_position = camera_2d.global_position
	death_zone.body_entered.connect(func(body: PlatformerPlayer):
		if(GameManager.access_platformer_invincibility):
			body.jump(3)
			pass
		else :
			SceneManager.next_game()
	)
	
func _process(delta: float) -> void:
	GameManager.set_access_color(parallax_sprite_2d, GameManager.Colors.BACKGROUND)
	if player.global_position.x > camera_target_position.x:
		camera_target_position.x = player.global_position.x
	camera_2d.global_position = lerp(camera_2d.global_position, camera_target_position, delta * 5.0)
	
	player.position.x = max(player.position.x, camera_2d.position.x - get_viewport_rect().size.x / 2.0)
