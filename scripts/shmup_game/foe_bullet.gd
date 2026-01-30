class_name FoeBullet extends Area2D

@export var speed : Vector2
@export var rotate_speed : float = -1

@onready var sprite_2d: Sprite2D = $SpriteContainer/Sprite2D

func _process(delta):
	rotate(rotate_speed * delta)
	position += speed * delta
	GameManager.set_access_color(sprite_2d, GameManager.Colors.ENEMY)
	if position.distance_to(get_viewport_rect().size / 2) > get_viewport_rect().size.length():
		queue_free()
