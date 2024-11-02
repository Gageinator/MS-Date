extends AudioStreamPlayer

@export var main_theme = "res://Audio/inki-minki-tinki-152746.mp3"

func _process(delta):
	if SignalBus.music_paused == true:
		stream_paused = true
	else:
		stream_paused = false

func _on_finished():
	play(0)
