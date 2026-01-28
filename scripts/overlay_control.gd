class_name OverlayControl extends Control

@onready var score_label: Label = $ScoreLabel

func _ready() -> void:
	score_label.text = str(GameManager.score)
	GameManager.score_update.connect(func(value):
		score_label.text = str(value)
	)
	
