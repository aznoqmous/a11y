class_name RacingPlayer extends Player

func _ready():
	area_entered.connect(func(area: Area2D):
		SceneManager.next_game()
	)
