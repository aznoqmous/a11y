class_name WinZone extends Area2D

func _ready():
	body_entered.connect(func(platformer: PlatformerPlayer):
		SceneManager.next_game()
	)
	
