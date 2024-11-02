extends Sprite2D

var curr_ending: String
var pink_kun_active = false
# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.connect("ending_receive", show_ending)

func show_ending(ending, pink):
	curr_ending = ending
	$AnimationPlayer.play(curr_ending)
	pink_kun_active = pink

func _on_credits_button_down():
	get_tree().change_scene_to_file("res://Scenes/credits.tscn")


func _on_restart_button_down():
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")


func _on_quit_button_down():
	get_tree().quit()
