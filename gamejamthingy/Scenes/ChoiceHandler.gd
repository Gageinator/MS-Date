extends Node

const buttonprefab = preload("res://Scenes/single_choice.tscn")

var choice_list = ["What do you mean?", "I don't know what you're talking about.", "Large rat"]
var choice_count: int = len(choice_list)
var choice_ids = []

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.connect("dialog_chosen", buttonpress)
	for i in range(choice_count):
		var new_instance = buttonprefab.instantiate()
		new_instance.text = choice_list[i]
		new_instance.position.y += i*100
		new_instance.choice_id = i
		add_child(new_instance)

func buttonpress(id):
	print(id)
