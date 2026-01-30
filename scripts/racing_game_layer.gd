extends CanvasLayer

@onready var player_health_slider: HSlider = $Control/Panel/MarginContainer/HBoxContainer/VBoxContainer/HBoxContainer3/PlayerHealthSlider
@onready var enemy_speed_slider: HSlider = $Control/Panel/MarginContainer/HBoxContainer/VBoxContainer/HBoxContainer/EnemySpeedSlider
@onready var spawn_speed_slider: HSlider = $Control/Panel/MarginContainer/HBoxContainer/VBoxContainer/HBoxContainer2/SpawnSpeedSlider
@onready var magnet_checkbox: CheckButton = $Control/Panel/MarginContainer/HBoxContainer/VBoxContainer/HBoxContainer4/MagnetCheckbox

@onready var play_button: Button = $PlayButton
@onready var quit_button: TextureButton = $Control/QuitButton

func _ready():
	quit_button.pressed.connect(func(): set_visible(false))
	play_button.pressed.connect(func(): 
		play_button.set_visible(false)
		set_visible(false)
	)
	player_health_slider.min_value = GameManager.racing_health_min
	player_health_slider.max_value = GameManager.racing_health_max
	player_health_slider.value = GameManager.access_racing_health
	player_health_slider.step = 1.0
	player_health_slider.drag_ended.connect(func(drag_ended):
		GameManager.access_racing_health = player_health_slider.value
	)
	
	enemy_speed_slider.min_value = GameManager.racing_enemy_speed_min
	enemy_speed_slider.max_value = GameManager.racing_enemy_speed_max
	enemy_speed_slider.value = GameManager.access_racing_enemy_speed
	enemy_speed_slider.step = 0.01
	enemy_speed_slider.drag_ended.connect(func(drag_ended):
		GameManager.access_racing_enemy_speed = enemy_speed_slider.value
	)
	
	spawn_speed_slider.min_value = GameManager.racing_spawn_speed_min
	spawn_speed_slider.max_value = GameManager.racing_spawn_speed_max
	spawn_speed_slider.value = GameManager.access_racing_spawn_speed
	spawn_speed_slider.step = 0.01
	spawn_speed_slider.drag_ended.connect(func(drag_ended):
		GameManager.access_racing_spawn_speed = spawn_speed_slider.value
	)
	
	magnet_checkbox.set_pressed_no_signal(GameManager.access_magnet)
	magnet_checkbox.toggled.connect(func(toggled):
		GameManager.access_magnet = toggled
	)
