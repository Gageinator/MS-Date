extends Node2D

# Initial Setup
# Current cursors are placeholders, might need another brush that looks more like Bristle

var cursor_type = "default"

var cursor_default = load("res://image assets/kenney_cursor-pack/PNG/Basic/Default/hand_point.png")
var cursor_brush = load("res://image assets/kenney_cursor-pack/PNG/Basic/Default/drawing_brush.png")
var cursor_eraser = load("res://image assets/kenney_cursor-pack/PNG/Basic/Default/drawing_eraser.png")

var brush_button_off = load("res://image assets/brush.png")
var brush_button_on = load("res://image assets/brush2.png")

var eraser_button_off = load("res://image assets/eraser.png")
var eraser_button_on = load("res://image assets/eraser2.png")

var savebox_visibility = 0

var savebox_time = 3.0
var cur_savebox = savebox_time
var savebox_faderate = .1

func _ready():
	Input.set_custom_mouse_cursor(cursor_default)
	
	$"brush button/Sprite2D".texture = brush_button_off
	$"eraser button/Sprite2D".texture = eraser_button_off
	$ColorDisplay/BrushTexture.visible = false
	$ColorDisplay/EraserTexture.visible = false
	
	
func _process(delta):
	if cursor_type == "brush":
		Input.set_custom_mouse_cursor(cursor_brush)
		$"brush button/Sprite2D".texture = brush_button_on
		$"eraser button/Sprite2D".texture = eraser_button_off
		$BrushSlider.visible = true
		$EraserSlider.visible = false
		$SizeLabel.visible = true
		
		$ColorDisplay/BrushTexture.visible = true
		$ColorDisplay/EraserTexture.visible = false
		$ColorDisplay/NoneTexture.visible = false
		
	
	elif cursor_type == "eraser":
		Input.set_custom_mouse_cursor(cursor_eraser)
		$"brush button/Sprite2D".texture = brush_button_off
		$"eraser button/Sprite2D".texture = eraser_button_on
		$EraserSlider.visible = true
		$BrushSlider.visible = false
		$SizeLabel.visible = true
		
		$ColorDisplay/BrushTexture.visible = false
		$ColorDisplay/EraserTexture.visible = true
		$ColorDisplay/NoneTexture.visible = false
	
	else:
		Input.set_custom_mouse_cursor(cursor_default)
		$"brush button/Sprite2D".texture = brush_button_off
		$"eraser button/Sprite2D".texture = eraser_button_off
		$BrushSlider.visible = false
		$EraserSlider.visible = false
		$SizeLabel.visible = false
		
		$ColorDisplay/BrushTexture.visible = false
		$ColorDisplay/EraserTexture.visible = false
		$ColorDisplay/NoneTexture.visible = true
	
	global.brush_size = $BrushSlider.value
	global.eraser_size = $EraserSlider.value
	
	if cur_savebox > 0:
		cur_savebox -= delta
	else:
		if savebox_visibility > 0:
			savebox_visibility -= savebox_faderate
	
	$SaveConfirmBox.modulate.a = savebox_visibility


# Buttons
func _on_save_button_pressed():
	#var numFiles = global.dir_num("") # Won't work until this code is in the main game's project files
	#get_viewport().get_texture().get_image().save_png("user://Screenshot.png")
	#print("Image saved")
	savebox_visibility = 1
	cur_savebox = savebox_time
	
func _on_quit_button_pressed():
	get_tree().quit() # Quits the whole game, replace with back to main menu once in project

func _on_brush_button_pressed():
	Input.set_custom_mouse_cursor(cursor_brush)
	cursor_type = "brush"
	
	global.brush_color = global.last_brush_color

func _on_eraser_button_pressed():
	Input.set_custom_mouse_cursor(cursor_eraser)
	cursor_type = "eraser"
	
	global.change_color(global.eraser_color)

# Input
func _input(event):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		if cursor_type != "default" and global.on_canvas:
			$Canvas/CanvasViewport.mouse_append()
	elif Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		Input.set_custom_mouse_cursor(cursor_default)
		cursor_type = "default"

func _on_canvas_mouse_entered():
	global.on_canvas = true

func _on_canvas_mouse_exited():
	global.on_canvas = false
