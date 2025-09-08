extends Area2D

@onready var sprite_2d: Sprite2D = $Sprite2D

@export var keyColour: String

var imageRoot = "res://assets/sprites/"
var imageEnding = "Key.png"
var playerCanPickUp = false

func _ready() -> void:
	sprite_2d.texture = load(imageRoot + keyColour + imageEnding)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pickUp") and playerCanPickUp:
		Inventory.numberOfKeys += 1
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	playerCanPickUp = true


func _on_body_exited(body: Node2D) -> void:
	playerCanPickUp = false
