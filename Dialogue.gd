extends RichTextLabel

# $ Blip sounds created with Chiptone https://sfbgames.itch.io/chiptone
# Credit to this tutorial for guide on making scrolling text https://www.youtube.com/watch?v=JZG4bUXFXCI

var dialogue = text

# Called when the node enters the scene tree for the first time.
func _ready():
	scroll_text(dialogue)

func scroll_text(input_text:String):
	visible_characters = 0
	text = input_text
	
	for i in get_parsed_text():
		visible_characters += 1
		$PlayerVoice.play() # Can be replaced with any of the characters' voices
		await get_tree().create_timer(0.025).timeout

