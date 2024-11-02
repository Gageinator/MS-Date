extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.pause_music()
	SignalBus.game_paused = true
	set_process_input(false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_resume_button_up():
	SignalBus.unpause_music()
	SignalBus.game_paused = false
	set_process_input(true)
	queue_free()


func _on_quit_button_up():
	get_tree().quit()
