extends Area2D





func _on_body_entered(body: Node2D) -> void:
	if(GameManager.access_platformer_auto_jump):
		if(body is PlatformerPlayer):
			body.jump()
	pass # Replace with function body.
