class_name RacingPlayer extends Player
@onready var arrow_container: Node2D = $ArrowContainer
@onready var sprite_2d: Sprite2D = $Sprite2D

func _ready():
	area_entered.connect(func(area: Area2D):
		SceneManager.next_game()
	)

func _process(delta: float) -> void:
	GameManager.set_access_color(sprite_2d, GameManager.Colors.PLAYER)
