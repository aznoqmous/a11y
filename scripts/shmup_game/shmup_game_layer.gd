extends CanvasLayer

@onready var player_health_slider: HSlider = $Control/Panel/MarginContainer/HBoxContainer/VBoxContainer/HBoxContainer/PlayerHealthSlider
@onready var player_fire_rate_slider: HSlider = $Control/Panel/MarginContainer/HBoxContainer/VBoxContainer/HBoxContainer2/PlayerFireRateSlider
@onready var player_speed_slider: HSlider = $Control/Panel/MarginContainer/HBoxContainer/VBoxContainer/HBoxContainer3/PlayerSpeedSlider
@onready var spawn_speed_slider: HSlider = $Control/Panel/MarginContainer/HBoxContainer/VBoxContainer/HBoxContainer4/SpawnSpeedSlider
@onready var quit_button: TextureButton = $Control/QuitButton
@onready var play_button: Button = $PlayButton

func _ready():
	quit_button.pressed.connect(func(): set_visible(false))
	play_button.pressed.connect(func(): 
		play_button.set_visible(false)
		set_visible(false)
	)
	player_health_slider.min_value = GameManager.shmup_health_min
	player_health_slider.max_value = GameManager.shmup_health_max
	player_health_slider.value = GameManager.access_shmup_health
	player_health_slider.drag_ended.connect(func(drag_ended):
		GameManager.access_shmup_health = player_health_slider.value
	)
	
	player_fire_rate_slider.min_value = 1.0 / GameManager.shmup_fire_rate_min
	player_fire_rate_slider.max_value = 1.0 / GameManager.shmup_fire_rate_max
	player_fire_rate_slider.step = 0.01
	player_fire_rate_slider.value = GameManager.access_shmup_fire_rate
	player_fire_rate_slider.drag_ended.connect(func(drag_ended):
		GameManager.access_shmup_fire_rate = 1.0 / player_fire_rate_slider.value
	)
	
	player_speed_slider.min_value = GameManager.shmup_player_speed_min
	player_speed_slider.max_value = GameManager.shmup_player_speed_max
	player_speed_slider.value = GameManager.access_shmup_player_speed
	player_speed_slider.drag_ended.connect(func(drag_ended):
		GameManager.access_shmup_player_speed = player_speed_slider.value
	)
	
	spawn_speed_slider.min_value = GameManager.shmup_spawn_speed_min
	spawn_speed_slider.max_value = GameManager.shmup_spawn_speed_max
	spawn_speed_slider.value = GameManager.access_shmup_spawn_speed
	spawn_speed_slider.step = 0.01
	spawn_speed_slider.drag_ended.connect(func(drag_ended):
		GameManager.access_shmup_spawn_speed = spawn_speed_slider.value
	)
	
