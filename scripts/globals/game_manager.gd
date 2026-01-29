extends Node

var score := 0.0
var time := 0.0

var access_audio_description : bool = false
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
		access_audio_description = !access_audio_description
		print("access_audio_description is now : ","enabled" if access_audio_description else "disabled")
	
func reset_time():
	time = 0.0
	
func gain_score(value):
	score += value
	score_update.emit(score)
	
signal score_update(value)
