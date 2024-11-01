extends Node

var on_canvas = false

var points: Array = []

var brush_color = Color.BLUE
var last_brush_color = brush_color

var eraser_color = Color.WHITE
var bg_color = eraser_color # Erasing is just brush that always has the background color and own size

var brush_size = null
var eraser_size = null

var canvas_size = null
var canvas_position = null

func change_color(new_color):
	last_brush_color = brush_color
	brush_color = new_color

func dir_num(path):
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		var count = 0
		while file_name != "":
			count += 1
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
