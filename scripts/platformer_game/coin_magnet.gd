extends Node2D

@onready var collision_shape_2d: CollisionShape2D = $CoinMagnet/CollisionShape2D

func _process(delta: float) -> void:
	if(GameManager.access_magnet):
		var shape:CircleShape2D = collision_shape_2d.shape
		shape.radius =lerp(50,250,GameManager.access_magnet_radius) 
	

func _on_area_2d_area_entered(area: Area2D) -> void:
	if(!GameManager.access_magnet):
		return
	if(area is ScoreStar):
		grab_item(area)
		
	pass # Replace with function body.

func grab_item(area:Node2D):
	while(area != null):
		var magnet_value = lerp(0.01,0.07,GameManager.access_magnet_strength_value)
		area.global_position = lerp(area.global_position,global_position,magnet_value)
		await get_tree().create_timer(0.01).timeout
		
	pass
	
