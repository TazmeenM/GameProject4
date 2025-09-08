extends Node2D

@onready var sprite_2d: Sprite2D = $Sprite2D

var imageRoot = "res://assets/sprites/"
var imageEnding = ".png"
var images = [1, 2, 3]
var currentImage = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite_2d.texture = imageRoot + str(images[currentImage]) + imageEnding


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_next_image_button_pressed() -> void:
	currentImage += 1
	if (currentImage < images.size()):
		sprite_2d.texture = imageRoot + str(images[currentImage]) + imageEnding
		if (currentImage == images.size() - 1):
			get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
