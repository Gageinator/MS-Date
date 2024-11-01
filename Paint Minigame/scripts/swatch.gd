extends TextureButton

@export var color: Color

@onready var base = $"../.."

# Called when the node enters the scene tree for the first time.
func _ready():
	$SwatchTexture.modulate = color

func _on_pressed():
	global.change_color(color)
	base.cursor_type = "brush"
