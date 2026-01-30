class_name ShmupLayer extends CanvasLayer

@export var health_textures : Array[TextureRect]
@export var health_color : Color

@onready var health_container: HBoxContainer = $Control/HealthContainer
@onready var player: ShmupPlayer = $"../World/Player"

func _ready() -> void:
	update_health()
	player.on_health_changed.connect(update_health)
	
func update_health():
	for i in health_textures.size():
			health_textures[i].set_visible(i < player.max_health)
			health_textures[i].modulate = health_color if i < player.current_health else Color.WHITE
