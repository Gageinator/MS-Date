extends Sprite2D

@export var ending_image: Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().create_timer(0.15).timeout
	print(ending_image.curr_ending, ending_image.pink_kun_active)
	if ending_image.curr_ending != "bucketina_bad" or not ending_image.pink_kun_active:
		queue_free()
