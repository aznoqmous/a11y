class_name Foe extends Area2D

@export var speed: Vector2 = Vector2.LEFT
@export var max_health := 1.0

var is_alive : bool : 
	get: return current_health > 0
	
var current_health := 0.0

func _ready():
	current_health = max_health

func _process(delta: float) -> void:
	position += delta * speed
	scale = lerp(scale, Vector2.ONE, delta * 5.0)

func take_damage(value):
	if not is_alive: return
	current_health -= value
	if not is_alive: die()
	scale = Vector2.ONE * 1.5
	
func die():
	queue_free()
