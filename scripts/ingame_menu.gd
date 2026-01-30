extends Node

@onready var game_button: TextureButton = $IngameMenu/Control/HBoxContainer/GameButton
@onready var inputs_button: TextureButton = $IngameMenu/Control/HBoxContainer/InputsButton
@onready var colors_button: TextureButton = $IngameMenu/Control/HBoxContainer/ColorsButton
@onready var audio_button: TextureButton = $IngameMenu/Control/HBoxContainer/AudioButton

@export var game_binding_layer : CanvasLayer
@export var inputs_binding_layer : CanvasLayer
@export var colors_binding_layer : CanvasLayer
@export var audio_binding_layer : CanvasLayer

func _ready():
	game_button.set_visible(!!game_binding_layer)
	game_button.pressed.connect(func():
		game_binding_layer.set_visible(true)
	)
	inputs_button.pressed.connect(func():
		inputs_binding_layer.set_visible(true)
	)
	colors_button.pressed.connect(func():
		colors_binding_layer.set_visible(true)
	)
	audio_button.pressed.connect(func():
		audio_binding_layer.set_visible(true)
	)
	
	game_button.mouse_entered.connect(func():
		game_button.scale = Vector2.ONE * 1.5
	)
	inputs_button.mouse_entered.connect(func():
		inputs_button.scale = Vector2.ONE * 1.5
	)
	colors_button.mouse_entered.connect(func():
		colors_button.scale = Vector2.ONE * 1.5
	)
	audio_button.mouse_entered.connect(func():
		audio_button.scale = Vector2.ONE * 1.5
	)

func _process(delta: float) -> void:
	Engine.time_scale = 0.0 if (game_binding_layer and game_binding_layer.visible) or inputs_binding_layer.visible or colors_binding_layer.visible or audio_binding_layer.visible else 1.0
	#get_tree().paused = inputs_binding_layer.visible or colors_binding_layer.visible
	game_button.scale = lerp(game_button.scale, Vector2.ONE, delta * 5.0)
	inputs_button.scale = lerp(inputs_button.scale, Vector2.ONE, delta * 5.0)
	colors_button.scale = lerp(colors_button.scale, Vector2.ONE, delta * 5.0)
	audio_button.scale = lerp(audio_button.scale, Vector2.ONE, delta * 5.0)
