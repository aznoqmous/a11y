class_name FoeBullet extends Area2D

@export var speed : Vector2

func _process(delta):
	position += speed * delta
