class_name RacingPlayer extends Player
@onready var arrow_container: Node2D = $ArrowContainer
@onready var sprite_2d: Sprite2D = $Sprite2D

@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var audio_stream_access_proximity: AudioStreamPlayer2D = $AudioAccessProximity

@export var min_volume_db = 0
@export var max_volume_db = 1
@export var maxDistance = 1000
func _ready():
	area_entered.connect(func(area: Area2D):
		SceneManager.next_game()
	)
	audio_stream_access_proximity.volume_db  = min_volume_db
	raycast_routine()
	
	
func raycast_routine() -> void:
	audio_stream_access_proximity.play()
	while(true):
		var lerpedVolume = 0
		await get_tree().create_timer(0.3).timeout
		var distance = 90000
		if(ray_cast_2d.is_colliding()):
			distance = ray_cast_2d.get_collision_point().distance_to(position)
		lerpedVolume = lerp(max_volume_db,min_volume_db,distance/maxDistance)
		print(lerpedVolume)
		audio_stream_access_proximity.volume_db = lerpedVolume
	pass

func _process(delta: float) -> void:
	GameManager.set_access_color(sprite_2d, GameManager.Colors.PLAYER)
