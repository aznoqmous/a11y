extends CanvasLayer

@onready var autojump_checkbox: CheckButton = $Control/Panel/MarginContainer/HBoxContainer/VBoxContainer/HBoxContainer/AutojumpCheckbox
@onready var invincibility_checkbox: CheckButton = $Control/Panel/MarginContainer/HBoxContainer/VBoxContainer/HBoxContainer2/InvincibilityCheckbox
@onready var automove_checkbox: CheckButton = $Control/Panel/MarginContainer/HBoxContainer/VBoxContainer/HBoxContainer3/AutomoveCheckbox
@onready var magnet_checkbox: CheckButton = $Control/Panel/MarginContainer/HBoxContainer/VBoxContainer/HBoxContainer4/MagnetCheckbox

@onready var quit_button: TextureButton = $Control/QuitButton

func _ready():
	quit_button.pressed.connect(func(): set_visible(false))
	
	autojump_checkbox.set_pressed_no_signal(GameManager.access_platformer_auto_jump)
	autojump_checkbox.toggled.connect(func(toggled):
		GameManager.access_platformer_auto_jump = toggled
	)
	
	invincibility_checkbox.set_pressed_no_signal(GameManager.access_platformer_auto_jump)
	invincibility_checkbox.toggled.connect(func(toggled):
		GameManager.access_platformer_invincibility = toggled
	)
	
	automove_checkbox.set_pressed_no_signal(GameManager.access_platformer_auto_jump)
	automove_checkbox.toggled.connect(func(toggled):
		GameManager.access_platformer_automove = toggled
	)
	
	magnet_checkbox.set_pressed_no_signal(GameManager.access_platformer_auto_jump)
	magnet_checkbox.toggled.connect(func(toggled):
		GameManager.access_platformer_magnet = toggled
	)
