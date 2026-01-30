class_name Magnet extends Node2D

@export var score_star: ScoreStar

@export var collision_shape_2d: CollisionShape2D
func _process(delta):
	if(GameManager.access_magnet):
		var shape:CircleShape2D = collision_shape_2d.shape
		shape.radius =lerp(50,250,GameManager.access_magnet_radius) 


func grab_item(area:Node2D):
	while(area != null):
		var magnet_value = lerp(0.01,0.07,GameManager.access_magnet_strength_value)
		score_star.global_position = lerp(score_star.global_position, area.global_position ,magnet_value)
		await get_tree().create_timer(0.01).timeout
		
	pass
	
func _on_body_entered(body: Node2D) -> void:
	if(!GameManager.access_magnet):
		return
	if(body.name == "Player"):
		grab_item(body)


func _on_area_entered(area: Area2D) -> void:
	if(!GameManager.access_magnet):
		return
	if(area.name == "Player"):
		grab_item(area)
		
	pass # Replace with function body.
