class_name Foe extends Area2D

@export var speed: Vector2 = Vector2.LEFT
@export var max_health := 1.0

@export_category("Bullet")
@export var bullet_scene : PackedScene
@export var bullet_speed := 100.0
@export var fire_cooldown := 1.0
var fire_time = 0.0

var is_alive : bool : 
	get: return current_health > 0
	
var current_health := 0.0

func _ready():
	current_health = max_health

func _process(delta: float) -> void:
	position += delta * speed
	scale = lerp(scale, Vector2.ONE, delta * 5.0)
	
	fire_time -= delta
	if bullet_scene and fire_cooldown and fire_time < 0:
		fire_time = fire_cooldown
		fire()
	
func take_damage(value):
	if not is_alive: return
	current_health -= value
	if not is_alive: die()
	scale = Vector2.ONE * 1.5

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
