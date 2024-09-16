extends Control

var save_data = {}

func read_save_data():
	# Assuming you have a SaveManager script that properly reads the save data
	# we should btw
	save_data = SaveManager.read_save()

func display_saved_data(label_node):
	var text = ""

	# Iterate through the saved data and concatenate dialogues and choices
	for element in save_data["dialoguesAndchoices"]:
		text += "\n" + element["choices"] + "\n"
		text += element["dialogues"]
		text += "\n" + element["choices"] + "\n"

	# Update the text of the Label node with the concatenated dialogues and choices
	label_node.text = text


# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.pause_music()
	SignalBus.game_paused = true
	set_process_input(false)
	
	var dialogue_label = $Sprite2D/scroll/Label
	read_save_data()
	display_saved_data(dialogue_label)

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
