extends Node

var score := 0.0
var time := 0.0

var access_audio_description : bool = false

### SMHUP
var shmup_fire_rate_value = 0.5
var shmup_fire_rate_min = 1.0
var shmup_fire_rate_max = 0.2
var access_shmup_fire_rate : float :
	get: return lerp(shmup_fire_rate_min, shmup_fire_rate_max, shmup_fire_rate_value)
	set(value): shmup_fire_rate_value = (value - shmup_fire_rate_min) / (shmup_fire_rate_max - shmup_fire_rate_min)
var _shmup_health_value := 0.5
var shmup_health_value : float :
	get: return _shmup_health_value
	set(value):
		_shmup_health_value = value
		on_shmup_health_update.emit()
signal on_shmup_health_update()
var shmup_health_min := 1
var shmup_health_max := 3
var access_shmup_health : int :
	get: return lerp(shmup_health_min, shmup_health_max, shmup_health_value)
	set(value): shmup_health_value = (value - shmup_health_min) / (shmup_health_max - shmup_health_min)
var shmup_player_speed_value = 0.5
var shmup_player_speed_min = 100.0
var shmup_player_speed_max = 500.0
var access_shmup_player_speed : float :
	get: return lerp(shmup_player_speed_min, shmup_player_speed_max, shmup_player_speed_value)
	set(value): shmup_player_speed_value = (value - shmup_player_speed_min) / (shmup_player_speed_max - shmup_player_speed_min)

var shmup_spawn_speed_value = 0.5
var shmup_spawn_speed_min = 1.0
var shmup_spawn_speed_max = 5.0
var access_shmup_spawn_speed : float :
	get: return lerp(shmup_spawn_speed_min, shmup_spawn_speed_max, shmup_spawn_speed_value)
	set(value): shmup_spawn_speed_value = (value - shmup_spawn_speed_min) / (shmup_spawn_speed_max - shmup_spawn_speed_min)

var access_animated_background = false

### PLATFORMER
#When set to true, the green zones in the LD will auto jump
var access_platformer_auto_jump = false

#When set to true, the green zones in the LD will auto jump
var access_platformer_magnet = false

var access_platformer_radius = 1
var access_platformer_strength_value = 1
var access_platformer_invincibility = false

var custom_colors: bool
enum Colors {
	PLAYER,
	ENEMY,
	COLLECTABLE,
	BACKGROUND
}
var colors = {
	Colors.PLAYER: Color("#0082ff"),
	Colors.ENEMY: Color.RED,
	Colors.COLLECTABLE: Color("#ffc500"),
	Colors.BACKGROUND: Color.WHITE,
}

func set_access_color(sprite: Sprite2D, type: Colors):
	if not sprite or not custom_colors: return;
	sprite.modulate = colors[type]

func _process(delta: float) -> void:
	time += delta
	
func _input(event: InputEvent) -> void:
	#DEBUG : add warning description sounds to the game 
	if(event is InputEventKey and event.is_pressed() and !event.is_echo() and event.keycode == KEY_F7):
		access_platformer_invincibility = !access_platformer_invincibility
		print("invincibility is now : ","enabled" if access_platformer_invincibility else "disabled")
	if(event is InputEventKey and event.is_pressed() and !event.is_echo() and event.keycode == KEY_F6):
		access_platformer_auto_jump = !access_platformer_auto_jump
		print("auto jump is now : ","enabled" if access_platformer_auto_jump else "disabled")
	if(event is InputEventKey and event.is_pressed() and !event.is_echo() and event.keycode == KEY_F5):
		access_platformer_magnet = !access_platformer_magnet
		print("magnet is now : ","enabled" if access_platformer_magnet else "disabled")
		
func reset_time():
	time = 0.0
	
func gain_score(value):
	score += value
	score_update.emit(score)
	
signal score_update(value)
