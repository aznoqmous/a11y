class_name ShmupScene extends Node

@export var star_score_scene : PackedScene

@onready var spawner: Spawner = $Spawner
@onready var parallax_sprite_2d: Sprite2D = $Decor/BackgroundParallax/ParallaxSprite2D
@onready var background_parallax_2: Parallax2D = $Decor/BackgroundParallax2

var base_coin_gain := 0.1
func _ready():
	base_coin_gain = spawner.spawn_base_gain
	
	spawner.on_spawn.connect(func(foe: Foe, index):
		foe.on_death.connect(func():
			var star = star_score_scene.instantiate()
			add_child(star)
			star.global_position = foe.global_position
			star.speed = foe.speed
		)
	)
	

func _process(delta: float) -> void:
	spawner.spawn_base_gain = base_coin_gain * GameManager.access_shmup_spawn_speed
	spawner.spawn_cooldown = GameManager.access_shmup_spawn_speed
	GameManager.set_access_color(parallax_sprite_2d, GameManager.Colors.BACKGROUND)
	background_parallax_2.autoscroll.x = -20 if GameManager.access_animated_background else 0
