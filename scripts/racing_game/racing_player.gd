class_name RacingPlayer extends Player
@onready var arrow_container: Node2D = $ArrowContainer
@onready var sprite_2d: Sprite2D = $Sprite2D

@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var audio_stream_access_proximity: AudioStreamPlayer2D = $AudioAccessProximity

@export var min_volume_db = 0
@export var max_volume_db = 1
@export var maxDistance = 1000

var max_health := GameManager.access_shmup_health
var _current_health := 1
var current_health : int :
	get: return _current_health
	set(value):
		_current_health = value
		on_health_changed.emit()
		

func _ready():
	area_entered.connect(func(area: Area2D):
		take_damage(1)
	)
	audio_stream_access_proximity.volume_db  = min_volume_db
	raycast_routine()
	GameManager.on_racing_health_update.connect(func():
		max_health = GameManager.access_racing_health
		current_health = max_health
	)
	
func raycast_routine() -> void:
	audio_stream_access_proximity.play()
	while(true):
		var lerpedVolume = 0
		await get_tree().create_timer(0.3).timeout
		var distance = 90000
		if(ray_cast_2d.is_colliding()):
			distance = ray_cast_2d.get_collision_point().distance_to(position)
		lerpedVolume = lerp(max_volume_db,min_volume_db,distance/maxDistance)
		audio_stream_access_proximity.volume_db = lerpedVolume
	pass

func take_damage(value):
	if current_health <= 0: return;
	current_health -= value
	if current_health <= 0:
		SceneManager.next_game()

func _process(delta: float) -> void:
	GameManager.set_access_color(sprite_2d, GameManager.Colors.PLAYER)

signal on_health_changed()
