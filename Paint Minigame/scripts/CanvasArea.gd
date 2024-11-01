extends Area2D

var click_pos = null

@onready var canvas_texture = get_node("../../CanvasTexture")
@onready var canvas_viewport = get_node("..")
@onready var base = get_node("../../..")

# Called when the node enters the scene tree for the first time.
func _ready():
	canvas_texture.texture = canvas_viewport.get_texture()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$".".queue_redraw()

func _draw():
	$".".draw_circle(Vector2(0, 0), 1000, global.bg_color) # Background
	
	for i in range(global.points.size()):
		$".".draw_circle(global.points[i]["Position"], global.points[i]["Size"], global.points[i]["Color"])

