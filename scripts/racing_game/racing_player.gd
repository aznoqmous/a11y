class_name RacingPlayer extends Player
@onready var arrow_container: Node2D = $ArrowContainer

func _ready():
	area_entered.connect(func(area: Area2D):
		SceneManager.next_game()
	)
