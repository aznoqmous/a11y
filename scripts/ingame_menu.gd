extends Node

@onready var inputs_button: Button = $IngameMenu/Control/HBoxContainer/InputsButton
@onready var colors_button: Button = $IngameMenu/Control/HBoxContainer/ColorsButton

@export var inputs_binding_layer : CanvasLayer
@export var colors_binding_layer : CanvasLayer

func _ready():
	inputs_button.pressed.connect(func():
		inputs_binding_layer.set_visible(true)
	)
	colors_button.pressed.connect(func():
		colors_binding_layer.set_visible(true)
	)

func _process(delta: float) -> void:
	Engine.time_scale = 0.0 if inputs_binding_layer.visible or colors_binding_layer.visible else 1.0
	#get_tree().paused = inputs_binding_layer.visible or colors_binding_layer.visible
