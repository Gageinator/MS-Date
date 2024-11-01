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


func image_count(path):
	print(path)
	var count = 0
	
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			count += 1
			file_name = dir.get_next()
	return count
	

func save_subviewport_as_jpg(viewport):
	var exe_path = OS.get_executable_path()
	var exe_dir = exe_path.get_base_dir()  # This part may still give an error, so use Directory
	var folder_name = "user images"
	var new_folder_path = exe_dir + "/" + folder_name
	
	var dir = DirAccess.open(exe_dir)
	if dir:
		dir.make_dir(folder_name)
		var file_name = dir.get_next()
		print("Folder created at: " + new_folder_path)
		
		var count = image_count(new_folder_path)
		

		dir.list_dir_end()
		
		
		var captured_image = Image.new()
		var img = viewport.get_texture().get_image()

		# Create a texture for it.
		var tex = ImageTexture.new()
		tex.create_from_image(img)
		
		var next_file_name = new_folder_path + "/Image" + str(count+1) + ".png"
		img.save_jpg(next_file_name)
		print("Image saved as", next_file_name)
		
	else:
		print("Failed to access the directory.")
	
	
	


