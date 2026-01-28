class_name ScoreStar extends Area2D
@onready var sprite_2d: Sprite2D = $Sprite2D
@export var speed : Vector2

func _ready() -> void:
	area_entered.connect(func(area: Area2D):
		if area is PlayerBullet: return; # a la zob
		GameManager.gain_score(1)
		queue_free()
	)

	sprite_2d.rotate(randf() * PI)

func _process(delta: float) -> void:
	sprite_2d.rotate(delta * PI)
	sprite_2d.position.y = sin(Time.get_ticks_msec() / 1000.0 * PI)
	position += speed * delta
	
