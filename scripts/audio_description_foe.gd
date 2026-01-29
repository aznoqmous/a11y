class_name AudioDescriptionFoe extends Node2D

@export var audio_stream_foe:AudioStreamPlayer2D
@export var audio_stream_direction:AudioStreamPlayer2D


func play_sound(streamPosition, streamFoe):
	await get_tree().create_timer(1).timeout
	audio_stream_foe.stream = streamFoe
	audio_stream_direction.stream = streamPosition	
	
	
	audio_stream_foe.play()
	await audio_stream_foe.finished
	await get_tree().create_timer(0.1).timeout	
	if(GameManager.access_audio_description):
		audio_stream_direction.play()
	await get_tree().create_timer(1).timeout
	queue_free()
	pass
