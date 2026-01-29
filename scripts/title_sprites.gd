extends Sprite2D

var rand = randf_range(-1.0, 1.0)

func _ready():
	rotate(randf() * TAU)
	
func _process(delta):
	rotate(delta * rand * 4.0)
