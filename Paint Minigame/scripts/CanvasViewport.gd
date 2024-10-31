extends SubViewport

# Reference to the Area2D
@onready var base = $"../.."
@onready var canvas_area = $CanvasArea
@onready var canvas_viewport = self
@onready var canvas = $".."

func _ready():
	update_viewport_size()

func update_viewport_size():
	global.canvas_size = $CanvasArea/CanvasCollision.shape.size
	global.canvas_position = $CanvasArea.global_position
	canvas_viewport.size = global.canvas_size

func mouse_append():
	var new_point = {"Position": get_viewport().get_mouse_position(), "Color":  global.brush_color, "Size": global.brush_size}
	
	if base.cursor_type == "brush":
		new_point["Size"] = global.brush_size
	else:
		new_point["Size"] = global.eraser_size
	
	global.points.append(new_point)
