class_name TransitionLayer extends CanvasLayer

@onready var button: Button = $Control/Button

func _ready():
	button.pressed.connect(func():
		SceneManager.next_game()
	)
