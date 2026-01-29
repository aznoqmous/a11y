class_name RacingAudioDescription extends Node2D

@export var racing_scene:RacingScene 
@export var audio_description_source : AudioStreamPlayer2D

@export var lane_sound_array : Array[AudioStream]
@export var audio_description_foe_scene : PackedScene

@export var foe_position:Node2D
var current_lane = -1

func init() -> void:
	racing_scene.spawner.on_spawn.connect(func(foe:Foe, index):
		if(GameManager.access_audio_description):
			var foe_scene:AudioDescriptionFoe = audio_description_foe_scene.instantiate()
			foe_position.add_child(foe_scene)
			foe_scene.play_sound(lane_sound_array[index],foe.audio_description_stream)
	)
	pass

func _process(delta: float) -> void:
	if(GameManager.access_audio_description):
		if(current_lane == -1):
			pass
		elif(current_lane != racing_scene.selected_lane_index):
			#PLAY THE SOUND
			print("{Debug} We just Swapped lanes to lane ", racing_scene.selected_lane_index)
			play_sound(racing_scene.selected_lane_index)
		current_lane = racing_scene.selected_lane_index

	
func play_sound(laneIndex : int) -> void:
	audio_description_source.stream = lane_sound_array[laneIndex]
	audio_description_source.play()
