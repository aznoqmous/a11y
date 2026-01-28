extends Node

var score := 0
 
func gain_score(value):
	print("SCORED")
	score += value
	score_update.emit(score)
	
signal score_update(value)
