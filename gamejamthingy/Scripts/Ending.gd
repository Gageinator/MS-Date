extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	SignalBus.connect("ending_receive", show_ending)

func show_ending(ending):
	$AnimationPlayer.play(ending)
