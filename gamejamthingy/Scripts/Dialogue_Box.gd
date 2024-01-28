extends ColorRect

@export var dialogPath = "res://Dialog/Dialog0.json"
@export var textSpeed = 0.05

const choicemenu = preload("res://Scenes/choices.tscn")

var dialog
var phraseNum : int = 0
var finished : bool = false


func _ready():
	SignalBus.connect("dialog_chosen", choice_made)
	$Timer.wait_time = textSpeed
	dialog = getDialog()
	assert(dialog, "Dialog not found!")
	nextPhrase()
	
func _process(delta):
	$Indicator.visible = finished
	if Input.is_action_just_pressed("Action") or Input.is_action_just_pressed("ActionSpace"):
		if finished:
			nextPhrase()
		else: 
			$Story.visible_characters = len($Story.text)
	
func getDialog() -> Array:
	var f = FileAccess.open(dialogPath, FileAccess.READ)
	#print("f ",f)
	assert(f.file_exists(dialogPath),"File path does not exist")
	
	f.open(dialogPath, f.READ)
	#print("f2",f)
	var json = f.get_as_text()
	#print("json ",json)
	var json_object = JSON.new()
	#print("json object", json_object)
	json_object.parse(json)
	var output = json_object.data
	#print("output ", output)
	
	f.close()
	
	if typeof(output) == TYPE_ARRAY:
		return output
	else:
		return []
		
func nextPhrase():
	if phraseNum >= len(dialog):
		queue_free()
		return
	finished = false
	
	$Name.bbcode_text = dialog[phraseNum]["Name"]
	$Story.bbcode_text = dialog[phraseNum]["Story"]
	$backgrounds.change_bg(dialog[phraseNum]["Background"])
	$Portrait.change_portrait(dialog[phraseNum]["Portrait"])
	$Story.visible_characters = 0
	while $Story.visible_characters < len($Story.text):
		$Story.visible_characters += 1
		$Timer.start()
		await $Timer.timeout
	
	if "Choices" in dialog[phraseNum]:
		var dialog_choice = choicemenu.instantiate()
		dialog_choice.choice_list = dialog[phraseNum]["Choices"]
		add_child(dialog_choice)
	else:
		finished = true
		phraseNum += 1
	return

func choice_made(id):
	dialogPath = "res://Dialog/" + dialog[phraseNum]["Paths"][id]
	phraseNum = 0
	dialog = getDialog()
	assert(dialog, "Dialog not found!")
	$ChoiceHandler.queue_free()
	nextPhrase()
