class_name Player extends Area2D

func _ready():
	area_entered.connect(func(body: Area2D):
		print("Collided")
	)
	
func take_damage(value):
	pass
