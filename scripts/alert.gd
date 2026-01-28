class_name Alert extends Node2D
@onready var sprite_2d: Sprite2D = $Sprite2D
@export var duration := 1.0

func _ready():
	scale = Vector2.ZERO
	
func _process(delta):
	sprite_2d.modulate.a = sin(Time.get_ticks_msec() / (1000.0 * duration) * TAU) / 0.5 + 0.5
	duration -= delta
	scale = lerp(scale, Vector2.ONE, delta * 5.0)
	if duration < 0: queue_free()
