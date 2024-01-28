extends Node

signal dialog_chosen(choice_id)
signal ending_obtained(ending)
signal ending_receive(ending)
# Called when the node enters the scene tree for the first time.
func _ready():
	connect("ending_obtained", open_ending)

func open_ending(ending):
	get_tree().change_scene_to_file("res://Scenes/endings.tscn")
	SignalBus.ending_receive.emit(ending)
