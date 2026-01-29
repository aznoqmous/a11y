extends CanvasLayer

@onready var master_slider: HSlider = $Control/Panel/MarginContainer/VBoxContainer/HBoxContainer/MasterSlider
@onready var music_slider: HSlider = $Control/Panel/MarginContainer/VBoxContainer/HBoxContainer2/MusicSlider
@onready var sfx_slider: HSlider = $Control/Panel/MarginContainer/VBoxContainer/HBoxContainer3/SFXSlider
@onready var accessibility_slider: HSlider = $Control/Panel/MarginContainer/VBoxContainer/HBoxContainer4/AccessibilitySlider
@onready var quit_button: TextureButton = $Control/QuitButton

var master_index := 0
var music_index := 0
var sfx_index := 0
var accessibility_index := 0

func _ready():
	quit_button.pressed.connect(func(): set_visible(false))
	
	master_index= AudioServer.get_bus_index("Master")
	music_index= AudioServer.get_bus_index("Music")
	sfx_index= AudioServer.get_bus_index("SFX")
	accessibility_index= AudioServer.get_bus_index("AudioDescription")
	
	master_slider.value = AudioServer.get_bus_volume_linear(master_index)
	music_slider.value = AudioServer.get_bus_volume_linear(music_index)
	sfx_slider.value = AudioServer.get_bus_volume_linear(sfx_index)
	accessibility_slider.value = AudioServer.get_bus_volume_linear(accessibility_index)
	
func _process(delta: float) -> void:
	AudioServer.set_bus_volume_linear(master_index, master_slider.value)
	AudioServer.set_bus_volume_linear(music_index, music_slider.value)
	AudioServer.set_bus_volume_linear(sfx_index, sfx_slider.value)
	AudioServer.set_bus_volume_linear(accessibility_index, accessibility_slider.value)
	
