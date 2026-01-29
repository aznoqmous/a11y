extends Node2D
@onready var play_button: Button = $CanvasLayer/Control/VBoxContainer/PlayButton
@onready var exit_button: Button = $CanvasLayer/Control/VBoxContainer/ExitButton

func _ready():
	play_button.pressed.connect(func():
		SceneManager.load_scene(SceneManager.racing_scene)
	)
	exit_button.pressed.connect(func():
		get_tree().quit()
	)
	
