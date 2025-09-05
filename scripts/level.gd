class_name Level extends Node2D

@export var player: Player
@export var respawn_timer: Timer
@export var fireball: Area2D


var isResetting = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("usePotion") and Inventory.potions["speedPotion"]["numberOfPotions"] > 0 and player.potionAffecting == false:
		Inventory.removePotions(1, "speedPotion")
		player.potionAffecting = true
		player.potion_timer.start()
	if Input.is_action_just_pressed("useHealthPotion") and Inventory.potions["healthPotion"]["numberOfPotions"] > 0:
		Inventory.removePotions(1, "healthPotion")
		player.increaseHealth(Inventory.potions["healthPotion"]["affectingInteger"])
	if Inventory.health == 0 and !isResetting:
		respawn_timer.start()
		fireball.movement_timer.stop()
		fireball.resetPosition()
		isResetting = true
	if Inventory.health == 0 and isResetting:
		print("Already Resetting")
		

func _on_respawn_timer_timeout() -> void:
	isResetting = false
	respawn_timer.stop()
	Inventory.reset()
	get_tree().reload_current_scene()
