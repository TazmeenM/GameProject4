extends Node2D

@onready var scroll_text: Label = $ScrollText
@onready var text_timer: Timer = $TextTimer
@onready var next_level_button: Button = $NextLevelButton
@onready var to_be_continued_label: Label = $ToBeContinuedLabel

var textOnScroll = "So you've found both keys and unlocked this treasure chest? Well done, mage. However, I regret to inform you that I cannot give you what you are looking for. Those secrets are hidden in the potions you've discovered so far..."
var textIndex = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	scroll_text.text = ""
	next_level_button.visible = false
	to_be_continued_label.visible = false
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
		to_be_continued_label.visible = true
		next_level_button.visible = true
		

func _on_next_level_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
