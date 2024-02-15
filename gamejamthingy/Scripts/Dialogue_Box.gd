extends ColorRect

@export var dialogPath = "res://Dialog/Dialog0.json"
@export var textSpeed = 0.05
var making_choice: bool = false
const choicemenu = preload("res://Scenes/choices.tscn")
const pausemenu = preload("res://Scenes/pause_menu.tscn")

var dialog
var phraseNum : int = 0
var finished : bool = false
var pink_kun_acquired: bool = false
var voice_list: Dictionary = {
	"cursor_kun":"PlayerVoice",
	"cursor_intro":"PlayerVoice",
	"pink_kun":"PlayerVoice",
	"none":"PlayerVoice",
	"walter":"SnippyVoice",
	"bucket_intro":"BucketVoice",
	"ares_intro":"AresVoice",
	"bristle_intro":"BristleVoice",
	"ares_sama":"AresVoice",
	"ares_close":"AresVoice",
	"bristle_chan":"BristleVoice",
	"bucketina_chan":"BucketVoice",
}

func _ready():
	SignalBus.connect("dialog_chosen", choice_made)
	$Timer.wait_time = textSpeed
	dialog = getDialog()
	assert(dialog, "Dialog not found!")
	nextPhrase()
	
func _process(delta):
	$Indicator.visible = finished
	if SignalBus.game_paused == false and not making_choice:
		if Input.is_action_just_pressed("pause"):
			var pause = pausemenu.instantiate()
			add_sibling(pause)

func _unhandled_input(event):
	if SignalBus.game_paused == false:
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
		if "Ending" in dialog[phraseNum - 1]:
			SignalBus.ending_obtained.emit(dialog[phraseNum - 1]["Ending"], pink_kun_acquired)
		queue_free()
		return
	finished = false
	
	$Name.bbcode_text = dialog[phraseNum]["Name"]
	$Story.bbcode_text = dialog[phraseNum]["Story"]
	$backgrounds.change_bg(dialog[phraseNum]["Background"])
	$Portrait.change_portrait(dialog[phraseNum]["Portrait"])
	if dialogPath == "res://Dialog/BucketinaChan1.json":
		pink_kun_acquired = true
	if dialogPath == "res://Dialog/BucketinaFailure.json" and pink_kun_acquired:
		$Portrait.change_portrait("pink_kun")
	var cur_voice = voice_list[dialog[phraseNum]["Portrait"]]
	$Story.visible_characters = 0
	
	while $Story.visible_characters < len($Story.text):
		$Story.visible_characters += 1
		get_node(cur_voice).play()
		$Timer.start()
		await $Timer.timeout
	
	if "Choices" in dialog[phraseNum]:
		var dialog_choice = choicemenu.instantiate()
		dialog_choice.choice_list = dialog[phraseNum]["Choices"]
		add_child(dialog_choice)
		making_choice = true
	else:
		finished = true
		phraseNum += 1
		if $skip_button.button_pressed:
			await get_tree().create_timer(1.5).timeout
			nextPhrase()
			return
	return

func choice_made(id):
	dialogPath = "res://Dialog/" + dialog[phraseNum]["Paths"][id]
	phraseNum = 0
	dialog = getDialog()
	assert(dialog, "Dialog not found!")
	$ChoiceHandler.queue_free()
	making_choice = false
	nextPhrase()
