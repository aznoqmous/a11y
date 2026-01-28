extends Node

var score := 0.0
var time := 0.0

func _process(delta: float) -> void:
	time += delta
	
func reset_time():
	time = 0.0
	
func gain_score(value):
	score += value
	score_update.emit(score)
	
signal score_update(value)
