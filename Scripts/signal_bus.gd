extends Node

signal dialog_chosen(choice_id)
signal ending_obtained(ending, pink)
signal ending_receive(ending, pink)
var music_paused = false
var game_paused = false

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("ending_obtained", open_ending)

func open_ending(ending, pink):
	get_tree().change_scene_to_file("res://Scenes/endings.tscn")
	await get_tree().create_timer(0.15).timeout
	SignalBus.ending_receive.emit(ending, pink)

func pause_music():
	music_paused = true

func unpause_music():
	music_paused = false
