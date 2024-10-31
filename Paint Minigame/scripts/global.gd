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
