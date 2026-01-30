class_name PlayerBullet extends Area2D

@export var speed : Vector2
@onready var sprite_2d: Sprite2D = $Sprite2D

func _ready() -> void:
	area_entered.connect(func(foe: Foe):
		foe.take_damage(1.0)
		queue_free()
	)

func _process(delta):
	GameManager.set_access_color(sprite_2d, GameManager.Colors.PLAYER)
	position += speed * delta
	if position.distance_to(get_viewport_rect().size / 2) > get_viewport_rect().size.length():
		queue_free()
