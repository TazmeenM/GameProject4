extends Area2D

@onready var sprite_2d: Sprite2D = $Sprite2D

var treasureChestAreaEntered = false


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("openTreasureChest"):
		openTreasureChest()
		


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		treasureChestAreaEntered = true


func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		treasureChestAreaEntered = false


func openTreasureChest() -> void:
	sprite_2d.texture = load("res://assets/sprites/treasureChestOpened.png")
