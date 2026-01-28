class_name ShmupScene extends Node

@export var star_score_scene : PackedScene
@onready var spawner: Spawner = $Spawner
func _ready():
	spawner.on_spawn.connect(func(foe: Foe):
		foe.on_death.connect(func():
			var star = star_score_scene.instantiate()
			add_child(star)
			star.global_position = foe.global_position
			star.speed = foe.speed
		)
	)
