class_name ShmupPlayer extends Area2D

var max_health := GameManager.access_shmup_health
var _current_health := 1
var current_health : int :
	get: return _current_health
	set(value):
		_current_health = value
		on_health_changed.emit()
		
@export var move_speed := 300.0

@export_category("Bullet")
@export var fire_speed := 0.2
@export var bullet_speed := 400.0
@export var bullet_scene : PackedScene
@export var bullet_parent : Node2D

@onready var sprite_2d: Sprite2D = $Sprite2D

var fire_time := 0.0

func _ready():
	area_entered.connect(func(area: Area2D):
		take_damage(1)
	)
	current_health = max_health
	
	GameManager.on_shmup_health_update.connect(func():
		max_health = GameManager.access_shmup_health
		current_health = max_health
	)

func _process(delta) -> void:
	GameManager.set_access_color(sprite_2d, GameManager.Colors.PLAYER)
	move_speed = GameManager.access_shmup_player_speed
	fire_speed = GameManager.access_shmup_fire_rate
	if Input.is_action_pressed("Up"):
		position.y -= delta * move_speed
	if Input.is_action_pressed("Down"):
		position.y += delta * move_speed
	if Input.is_action_pressed("Left"):
		position.x -= delta * move_speed
	if Input.is_action_pressed("Right"):
		position.x += delta * move_speed
		
	if Input.is_action_pressed("Space"):
		fire_time -= delta
		if fire_time < 0:
			fire()
			
	position.x = clamp(position.x, 0, get_viewport_rect().size.x)
	position.y = clamp(position.y, 0, get_viewport_rect().size.y)
	
func fire():
	fire_time = fire_speed
	var bullet : PlayerBullet = bullet_scene.instantiate()
	bullet_parent.add_child(bullet)
	bullet.speed = Vector2.RIGHT * bullet_speed
	bullet.global_position = global_position

func take_damage(value):
	if current_health <= 0: return;
	current_health -= value
	if current_health <= 0:
		SceneManager.next_game()

signal on_health_changed()
