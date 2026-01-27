@tool
extends StaticBody2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

func _process(delta: float) -> void:
	sprite_2d.scale = collision_shape_2d.shape.get_rect().size
	sprite_2d.position = collision_shape_2d.position
