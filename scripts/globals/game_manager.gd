extends Node

var score := 0.0
var time := 0.0

var custom_colors: bool
enum Colors {
	PLAYER,
	ENEMY,
	COLLECTABLE
}

var colors = {
	Colors.PLAYER: Color("#0082ff"),
	Colors.ENEMY: Color.RED,
	Colors.COLLECTABLE: Color("#ffc500"),
}

func set_access_color(sprite: Sprite2D, type: Colors):
	if not custom_colors: return;
	sprite.modulate = colors[type]

func _process(delta: float) -> void:
	time += delta
	
func reset_time():
	time = 0.0
	
func gain_score(value):
	score += value
	score_update.emit(score)
	
signal score_update(value)
