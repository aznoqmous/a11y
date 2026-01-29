class_name ColorsLayer extends CanvasLayer

@onready var custom_color_toggle: CheckButton = $Control/Panel/MarginContainer/VBoxContainer/HBoxContainer4/CustomColorToggle
@onready var colors_container: VBoxContainer = $Control/Panel/MarginContainer/VBoxContainer/ColorsContainer
@onready var player_color: ColorPickerButton = $Control/Panel/MarginContainer/VBoxContainer/ColorsContainer/HBoxContainer/PlayerColor
@onready var enemy_color: ColorPickerButton = $Control/Panel/MarginContainer/VBoxContainer/ColorsContainer/HBoxContainer2/EnemyColor
@onready var collectable_color: ColorPickerButton = $Control/Panel/MarginContainer/VBoxContainer/ColorsContainer/HBoxContainer3/CollectableColor

func _ready():
	colors_container.modulate.a = 1.0 if custom_color_toggle.is_pressed() else 0.0
	custom_color_toggle.toggled.connect(func(toggled):
		colors_container.modulate.a = 1.0  if toggled else 0.0
		GameManager.custom_colors = toggled
	)
	
	player_color.color = GameManager.colors[GameManager.Colors.PLAYER]
	enemy_color.color = GameManager.colors[GameManager.Colors.ENEMY]
	collectable_color.color = GameManager.colors[GameManager.Colors.COLLECTABLE]
	
	player_color.color_changed.connect(func(color: Color):
		GameManager.colors[GameManager.Colors.PLAYER] = color
	)
	enemy_color.color_changed.connect(func(color: Color):
		GameManager.colors[GameManager.Colors.ENEMY] = color
	)
	collectable_color.color_changed.connect(func(color: Color):
		GameManager.colors[GameManager.Colors.COLLECTABLE] = color
	)
	
