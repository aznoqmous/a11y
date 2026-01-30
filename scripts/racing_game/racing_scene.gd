class_name RacingScene extends Node2D
@export var lanes : Array[Node2D]
@export var alert_spawns : Array[Node2D]
@export var alert_scene : PackedScene
@export var racing_audio_description : RacingAudioDescription 

var selected_lane_index = 1
var selected_lane : Node2D :
	get : return lanes[selected_lane_index] 

var access_direction = 1

@onready var player: RacingPlayer = $World/Player
@onready var spawner: Spawner = $Spawner
@onready var world: Node2D = $World
@onready var parallax_2d: Parallax2D = $Decor/Parallax2D
@onready var background_parallax: Parallax2D = $Decor/BackgroundParallax
@onready var parallax_sprite_2d: Sprite2D = $Decor/BackgroundParallax/ParallaxSprite2D

var base_coin_gain := 0.1

func _ready():
	base_coin_gain = spawner.spawn_base_gain
	spawner.on_spawn.connect(func(foe: Foe, index):
		var alert = alert_scene.instantiate()
		alert_spawns[index].add_child(alert)
		alert.position = Vector2.LEFT.rotated(randf() * TAU) * randf() * 30.0
		foe.speed = foe.speed.normalized() * GameManager.access_racing_enemy_speed
	)
	player.arrow_container.scale.y = -get_access_direction()
	racing_audio_description.init()
	
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
	spawner.spawn_base_gain = base_coin_gain * GameManager.access_racing_spawn_speed
	spawner.spawn_cooldown = GameManager.access_racing_spawn_speed
	GameManager.set_access_color(parallax_sprite_2d, GameManager.Colors.BACKGROUND)
	player.position = player.position.lerp(selected_lane.position, delta * 10.0)
	parallax_2d.autoscroll.x = -600 if GameManager.access_animated_background else 0
	background_parallax.autoscroll.x = -600 if GameManager.access_animated_background else 0
	
func get_access_direction():
	var access_dir = access_direction
	if selected_lane_index + access_direction < 0 or selected_lane_index + access_direction >= lanes.size():
		access_dir = -access_dir
	return access_dir
