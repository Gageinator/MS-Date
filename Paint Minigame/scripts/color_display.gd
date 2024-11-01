extends TextureButton

@onready var base = $".."

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if base.cursor_type != "default":
		$SwatchTexture.modulate = global.brush_color
	else:
		$SwatchTexture.modulate = Color.WHITE
