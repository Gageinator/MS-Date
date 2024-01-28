extends AudioStreamPlayer

@export var main_theme = "res://Audio/inki-minki-tinki-152746.mp3"

func _on_finished():
	play(main_theme)
