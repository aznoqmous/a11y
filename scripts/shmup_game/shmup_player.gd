class_name ShmupPlayer extends Area2D

@export var move_speed := 300.0
@export var fire_speed := 0.2
@export var bullet_speed := 400.0
@export var bullet_scene : PackedScene
@export var bullet_parent : Node2D

var fire_time := 0.0

func _ready():
	area_entered.connect(func(area: Area2D):
		SceneManager.next_game()
	)

func _process(delta) -> void:
	if Input.is_action_pressed("Up"):
		position.y -= delta * move_speed
	if Input.is_action_pressed("Down"):
		position.y += delta * move_speed
	if Input.is_action_pressed("Left"):
		position.x -= delta * move_speed
	if Input.is_action_pressed("Right"):
		position.x += delta * move_speed
		
	if Input.is_action_pressed("LeftClick"):
		fire_time -= delta
		if fire_time < 0:
			fire()

func fire():
	fire_time = fire_speed
	var bullet : PlayerBullet = bullet_scene.instantiate()
	bullet_parent.add_child(bullet)
	bullet.speed = Vector2.RIGHT * bullet_speed
	bullet.global_position = global_position
