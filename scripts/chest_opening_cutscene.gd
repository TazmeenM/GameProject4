extends Node2D

@onready var scroll_text: Label = $ScrollText
@onready var text_timer: Timer = $TextTimer

var textOnScroll = "So you've found the secret treasure chest, mage. Well, I suppose it's now time to give you all of my secrets...not. Did you think it would be so easy to discover 2000-year old secrets? Well, I don't think so. You were a bit too late, mage. I have hidden the real secrets somewhere you can only open with two keys, one blue and one purple. Find both keys, and you shall find the secrets."
var textIndex = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	scroll_text.text = ""
	text_timer.start()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func typewrite() -> void:
	scroll_text.text += textOnScroll[textIndex]
	textIndex += 1


func _on_text_timer_timeout() -> void:
	if textIndex < textOnScroll.length():
		typewrite()
	else:
		get_tree().change_scene_to_file("res://scenes/dungeon_1.tscn")
