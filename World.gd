extends Node2D

# Button sound from Fupi on opengameart.org https://opengameart.org/content/8bit-menu-select

func _on_button_pressed():
	$Button/AudioStreamPlayer.play()
