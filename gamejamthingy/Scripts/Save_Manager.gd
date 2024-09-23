extends Node

var json = JSON.new()
var path = "user://data.json"
var data = {}

# Function to add variables to the dialogues and choices fields
func add_variables_to_json(dialogues, choices):
	# Ensure that the "dialoguesAndchoices" array exists
	if not data.has("dialoguesAndchoices"):
		data["dialoguesAndchoices"] = []

	# Append the new dialogues and choices to the array
	data["dialoguesAndchoices"].append({"dialogues": dialogues, "choices": choices})

	# Save the modified data back to the file
	write_save(data)

# Function to write and save the JSON content to the file
func write_save(content):
	var file = FileAccess.open(path, FileAccess.WRITE)
	file.store_string(json.stringify(content))
	file.close()
	file = null

# Function to read the JSON content from the file
func read_save():
	var file = FileAccess.open(path, FileAccess.READ)
	var content = json.parse_string(file.get_as_text())
	return content 

# Function to create a new save file based on a default template
func create_new_save_file():
	var file = FileAccess.open("res://scripts/default_save.json", FileAccess.READ)
	var content = json.parse_string(file.get_as_text())
	data = content
	write_save(content)

func _ready():
	create_new_save_file()
	
