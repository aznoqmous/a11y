extends CanvasLayer

@onready var inputs_button: Button = $Control/InputsButton
@onready var colors_button: Button = $Control/ColorsButton

@export var inputs_binding_layer : CanvasLayer
@export var colors_binding_layer : CanvasLayer

func _ready():
	inputs_button.pressed.connect(func():
		inputs_binding_layer.set_visible(true)
	)
	colors_button.pressed.connect(func():
		colors_binding_layer.set_visible(true)
	)
	
