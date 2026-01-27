class_name PlayerBullet extends Area2D

@export var speed : Vector2

func _ready() -> void:
	area_entered.connect(func(foe: Foe):
		foe.take_damage(1.0)
		queue_free()
	)

func _process(delta):
	position += speed * delta
