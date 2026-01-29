extends CanvasLayer
@onready var quit_button: TextureButton = $Control/QuitButton

func _ready() -> void:
	quit_button.pressed.connect(func(): set_visible(false))
	
