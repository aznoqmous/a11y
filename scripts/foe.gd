class_name Foe extends Area2D

@export var max_health := 1.0
@export var speed: Vector2 = Vector2.LEFT
@export var speed_scaling := 0.01

@export var rotation_speed := 0.0
@export_range(0.0, 1.0, 0.1) var rotation_speed_random := 0.0

@export_category("Bullet")
@export var bullet_scene : PackedScene
@export var bullet_speed := 100.0
@export var fire_cooldown := 1.0

@export_category("Access")
@export var audio_description_stream:AudioStream

var fire_time = 0.0
var current_speed := Vector2.ZERO

@onready var sprite_container: Node2D = $SpriteContainer

@onready var sprite_2d: Node2D = $SpriteContainer/Sprite2D

var is_alive : bool : 
	get: return current_health > 0
	
var current_health := 0.0
var current_lane
func _ready():
	GameManager.set_access_color(sprite_2d, GameManager.Colors.ENEMY)
	current_speed = speed
	current_health = max_health
	rotation_speed = lerp(rotation_speed, rotation_speed * randf(), rotation_speed_random)
	if rotation_speed > 0: rotate(randf() * TAU);

func _process(delta: float) -> void:
	current_speed = speed * (1.0 + speed_scaling * GameManager.time)
	position += delta * current_speed
	sprite_container.scale = lerp(sprite_container.scale, Vector2.ONE, delta * 5.0)
	sprite_container.rotate(rotation_speed * TAU * delta)
	fire_time -= delta
	if bullet_scene and fire_cooldown and fire_time < 0:
		fire_time = fire_cooldown
		fire()
	
func take_damage(value):
	if not is_alive: return
	current_health -= value
	if not is_alive: die()
	sprite_container.scale = Vector2.ONE * 1.5

func fire():
	var bullet := bullet_scene.instantiate() as FoeBullet
	bullet.speed = Vector2.LEFT * bullet_speed
	bullet.global_position = global_position
	get_parent().add_child(bullet)
	pass

func die():
	on_death.emit()
	queue_free()

signal on_death()
