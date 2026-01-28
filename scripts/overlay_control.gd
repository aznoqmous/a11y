class_name OverlayControl extends CanvasLayer

@onready var score_label: Label = $Control/ScoreLabel

func _ready() -> void:
	score_label.text = str(GameManager.score)
	GameManager.score_update.connect(func(value):
		score_label.text = str(int(value))
	)
	
